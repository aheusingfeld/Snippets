import javax.net.ssl.*;
import java.io.*;
import java.net.Socket;
import java.security.KeyStore;
import java.security.MessageDigest;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

/**
 * Tool to fetch certificates from server and install it into local keystore.
 * Modified the version in the first URL with {@link #doTunnelHandshake()} of
 * second URL to be able to use proxy Connections.
 * <p/>
 * <b>Call this like:</b>
 * <code>
 * java -cp ./InstallCertClasses/ net.epdiwi.tools.InstallCert &lt;hostname&gt; KEYSTORE_PASSWORD PATH_TO_KEYSTORE_FOLDER
 * </code>
 *
 * @author d_heusingf and the following
 * @see http://blogs.sun.com/andreas/entry/no_more_unable_to_find
 * @see http://www.velocityreviews.com/forums/t132911-long-delay-using-sslsocketfactory.html
 * @see http://svn.ep.de/trac/diwi/wiki/InstallCert
 */
public final class InstallCert {

    private static String proxyHost;
    private static int proxyPort = 3128;

    /**
     * hidden default constructor.
     */
    private InstallCert() {

    }

    /**
     * @param args - arguments
     *             1. URL/ IP-address
     *             2. (optional) PASSWORD for keystore
     *             3. (optional) path to folder containing keystore
     *             4. (optional) name of the proxy server
     *             5. (optional) port of the proxy server
     * @throws Exception - if system property "java.home" cannot be read
     */
    public static void main(final String[] args) throws Exception {
        String host;
        int port;
        final char sep = File.separatorChar;

        char[] passphrase;
        String path = System.getProperty("java.home") + sep + "lib" + sep + "security";
        if ((args.length >= 1) && (args.length <= 5)) {
            String[] c = args[0].split(":");
            host = c[0];
            port = (c.length == 1) ? 443 : Integer.parseInt(c[1]);
            String p = (args.length == 1) ? "changeit" : args[1];
            passphrase = p.toCharArray();
            if (args.length == 3) {
                path = args[2];
            } else if (args.length == 5) {
                proxyHost = args[4];
                proxyPort = Integer.valueOf(args[5]);
            }
        } else {
            System.out
                    .println("Usage: java InstallCert <host>[:port] [passphrase] [path/to/cacerts-dir]");
            return;
        }


        File file = new File("jssecacerts");
        if (!file.isFile()) {
            final File dir = new File(path);
            file = new File(dir, "jssecacerts");
            if (!file.isFile()) {
                file = new File(dir, "cacerts");
            }
        }
        System.out.println("Loading KeyStore " + file + "...");
        final InputStream in = new FileInputStream(file);
        final KeyStore ks = KeyStore.getInstance(KeyStore.getDefaultType());
        ks.load(in, passphrase);
        in.close();

        final SSLContext context = SSLContext.getInstance("TLS");
        final TrustManagerFactory tmf = TrustManagerFactory
                .getInstance(TrustManagerFactory.getDefaultAlgorithm());
        tmf.init(ks);
        final X509TrustManager defaultTrustManager = (X509TrustManager) tmf
                .getTrustManagers()[0];
        final SavingTrustManager tm = new SavingTrustManager(defaultTrustManager);
        context.init(null, new TrustManager[]{tm}, null);
        final SSLSocketFactory factory = context.getSocketFactory();

        SSLSocket socket;
        if (proxyHost != null) {
            System.out.println("Opening connection to " + host + ":" + port + " through proxy...");
            socket = new Socket(proxyHost, proxyPort);
            doTunnelHandshake(socket, host, port);

            socket.setSoTimeout(120000);
        } else {
            System.out.println("Opening direct connection to " + host + ":" + port + "...");
            socket = (SSLSocket) factory.createSocket(host,
                    port);
            socket.setSoTimeout(60000);
        }
        socket.setKeepAlive(true);
        socket.setUseClientMode(true);
        try {
            System.out.println("Starting SSL handshake...");
            socket.startHandshake();
            socket.close();
            System.out.println();
            System.out.println("No errors, certificate is already trusted");
        } catch (SSLException e) {
            System.out.println();
            e.printStackTrace(System.out);
        }

        X509Certificate[] chain = tm.chain;
        if (chain == null) {
            System.out.println("Could not obtain server certificate chain");
            return;
        }

        BufferedReader reader = new BufferedReader(new InputStreamReader(
                System.in));

        System.out.println();
        System.out.println("Server sent " + chain.length + " certificate(s):");
        System.out.println();
        final MessageDigest sha1 = MessageDigest.getInstance("SHA1");
        final MessageDigest md5 = MessageDigest.getInstance("MD5");
        for (int i = 0; i < chain.length; i++) {
            final X509Certificate cert = chain[i];
            System.out.println(" " + (i + 1) + " Subject "
                    + cert.getSubjectDN());
            System.out.println("   Issuer  " + cert.getIssuerDN());
            sha1.update(cert.getEncoded());
            System.out.println("   sha1    " + toHexString(sha1.digest()));
            md5.update(cert.getEncoded());
            System.out.println("   md5     " + toHexString(md5.digest()));
            System.out.println();
        }

        System.out
                .println("Enter certificate to add to trusted keystore or 'q' to quit: [1]");
        String line = reader.readLine().trim();
        int k;
        try {
            k = (line.length() == 0) ? 0 : Integer.parseInt(line) - 1;
        } catch (NumberFormatException e) {
            System.out.println("KeyStore not changed");
            return;
        }

        final X509Certificate cert = chain[k];
        sha1.update(cert.getEncoded());
        final String alias = host + "-" + (k + 1) + "_SHA1:_" + toHexString(sha1.digest()).replace(' ', ':');
        ks.setCertificateEntry(alias, cert);

        final OutputStream out = new FileOutputStream(file);
        ks.store(out, passphrase);
        out.close();

        System.out.println();
        System.out.println(cert);
        System.out.println();
        System.out
                .println("Added certificate to keystore '" + file.getAbsolutePath() + "' using alias '"
                        + alias + "'");
    }

    private static final char[] HEXDIGITS = "0123456789abcdef".toCharArray();

    /**
     * @param bytes - byte array to be converted
     * @return hex string representation of the byte array
     */
    private static String toHexString(final byte[] bytes) {
        StringBuilder sb = new StringBuilder(bytes.length * 3);
        for (int b : bytes) {
            b &= 0xff;
            sb.append(HEXDIGITS[b >> 4]);
            sb.append(HEXDIGITS[b & 15]);
            sb.append(' ');
        }
        return sb.toString();
    }

    /**
     * @author d_heusingf
     *
     */
    /**
     * @author d_heusingf
     */
    private static final class SavingTrustManager implements X509TrustManager {

        private final X509TrustManager tm;
        private X509Certificate[] chain;

        /**
         * @param tm - trust manager
         */
        private SavingTrustManager(final X509TrustManager tm) {
            this.tm = tm;
        }

        /**
         * @return UnsupportedOperationException
         * @throws UnsupportedOperationException always!!!
         * @see javax.net.ssl.X509TrustManager#getAcceptedIssuers()
         */
        public X509Certificate[] getAcceptedIssuers() {
            throw new UnsupportedOperationException();
        }

        /**
         * @param chain    ???
         * @param authType ???
         * @throws CertificateException          never!
         * @throws UnsupportedOperationException always!!!
         * @see javax.net.ssl.X509TrustManager#checkClientTrusted(java.security.cert.X509Certificate[], java.lang.String)
         */
        public void checkClientTrusted(final X509Certificate[] chain, final String authType)
                throws CertificateException {
            throw new UnsupportedOperationException();
        }

        /**
         * @param chain    - the peer certificate chain
         * @param authType - the key exchange algorithm used
         * @throws IllegalArgumentException if null or zero-length chain is passed in for the chain parameter or if null or zero-length string is passed in for the authType parameter
         * @throws CertificateException     if the certificate chain is not trusted by this TrustManager.
         * @see javax.net.ssl.X509TrustManager#checkServerTrusted(java.security.cert.X509Certificate[], java.lang.String)
         */
        public void checkServerTrusted(final X509Certificate[] chain, final String authType)
                throws CertificateException {
            this.chain = chain;
            tm.checkServerTrusted(chain, authType);
        }
    }

    /**
     * @param tunnel tunnel socket
     * @param host   destination host
     * @param port   destination port
     * @throws IOException raised when an IO error occurs
     */
    private static void doTunnelHandshake(final Socket tunnel, final String host, final int port)
            throws IOException {
        System.out.println("SSLTunnelSocketFactory: doTunnelHandshake - doTunnelHandshake start");
        OutputStream out = tunnel.getOutputStream();
        StringBuilder builder = new StringBuilder();
        builder.append("CONNECT ")
                .append(host)
                .append(":")
                .append(port)
                .append(" HTTP/1.1\nHost: " + host + "\nUser-Agent: Java/1.6.0_32\nContent-Length: 0\nPragma: no-cache\r\n\r\n");
        // generate connection string
        String msg = builder.toString();

        System.out.println("SSLTunnelSocketFactory: doTunnelHandshake - msg: "
                + msg);

        byte[] b;
        try {
            // we really do want ASCII7 as the http protocol doesnt change with locale
            b = msg.getBytes("ASCII7");
        } catch (UnsupportedEncodingException ignored) {
            // If ASCII7 isn't there, something is seriously wrong!
            b = msg.getBytes();
        }
        out.write(b);
        out.flush();

        byte[] reply = new byte[200];
        int replyLen = 0;
        int newlinesSeen = 0;
        boolean headerDone = false;

        final InputStream in = tunnel.getInputStream();

        while (newlinesSeen < 2) {
            int i = in.read();
            if (i < 0) {
                throw new IOException("Unexpected EOF from Proxy");
            }
            if (i == '\n') {
                headerDone = true;
                ++newlinesSeen;
            } else if (i != '\r') {
                newlinesSeen = 0;
                if (!headerDone && replyLen < reply.length) {
                    reply[replyLen++] = (byte) i;
                }
            }
        }

        // convert byte array to string
        String replyStr;
        try {
            replyStr = new String(reply, 0, replyLen, "ASCII7");
        } catch (UnsupportedEncodingException ignored) {
            replyStr = new String(reply, 0, replyLen);
        }

        // we check for connection established because our proxy returns
        // http/1.1 instead of 1.0
        if (replyStr.toLowerCase().indexOf("200 connection established") == -1) {
            System.out
                    .println("SSLTunnelSocketFactory: doTunnelHandshake - replyStr: "
                            + replyStr);
            System.err.println(replyStr);
            throw new IOException("Unable to tunnel through " + proxyHost + ":"
                    + proxyPort + ". Proxy returns\"" + replyStr + "\"");
        }
        // tunneling hanshake was successful
    }

}
