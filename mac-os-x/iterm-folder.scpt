FasdUAS 1.101.10   ��   ��    k             l     ��  ��    x r cd to the current finder window folder in iTerm. Or drag a folder onto this script to cd to that folder in iTerm.     � 	 	 �   c d   t o   t h e   c u r r e n t   f i n d e r   w i n d o w   f o l d e r   i n   i T e r m .   O r   d r a g   a   f o l d e r   o n t o   t h i s   s c r i p t   t o   c d   t o   t h a t   f o l d e r   i n   i T e r m .   
  
 l     ��������  ��  ��        l     ��  ��      Instructions for use:     �   ,   I n s t r u c t i o n s   f o r   u s e :      l     ��  ��    { u paste this script into Script Editor and save as an application to ~/Library/Scripts/Applications/Finder/cd-to-iTerm     �   �   p a s t e   t h i s   s c r i p t   i n t o   S c r i p t   E d i t o r   a n d   s a v e   a s   a n   a p p l i c a t i o n   t o   ~ / L i b r a r y / S c r i p t s / A p p l i c a t i o n s / F i n d e r / c d - t o - i T e r m      l     ��  ��    W Q run via the AppleScript Menu item (http://www.apple.com/applescript/scriptmenu/)     �   �   r u n   v i a   t h e   A p p l e S c r i p t   M e n u   i t e m   ( h t t p : / / w w w . a p p l e . c o m / a p p l e s c r i p t / s c r i p t m e n u / )      l     ��������  ��  ��        l     ��   ��    s m Or better yet, Control-click and drag it to the top of a finder window so it appears in every finder window.      � ! ! �   O r   b e t t e r   y e t ,   C o n t r o l - c l i c k   a n d   d r a g   i t   t o   t h e   t o p   o f   a   f i n d e r   w i n d o w   s o   i t   a p p e a r s   i n   e v e r y   f i n d e r   w i n d o w .   " # " l     ��������  ��  ��   #  $ % $ l     �� & '��   & B < Activate it by clicking on it or dragging a folder onto it.    ' � ( ( x   A c t i v a t e   i t   b y   c l i c k i n g   o n   i t   o r   d r a g g i n g   a   f o l d e r   o n t o   i t . %  ) * ) l     ��������  ��  ��   *  + , + l     ��������  ��  ��   ,  - . - l     �� / 0��   / M G Another nice touch is to give the saved script the same icon as iTerm.    0 � 1 1 �   A n o t h e r   n i c e   t o u c h   i s   t o   g i v e   t h e   s a v e d   s c r i p t   t h e   s a m e   i c o n   a s   i T e r m . .  2 3 2 l     �� 4 5��   4 [ U To do this, in the finder, Get info (Command-I) of both iTerm and this saved script.    5 � 6 6 �   T o   d o   t h i s ,   i n   t h e   f i n d e r ,   G e t   i n f o   ( C o m m a n d - I )   o f   b o t h   i T e r m   a n d   t h i s   s a v e d   s c r i p t . 3  7 8 7 l     �� 9 :��   9 V P Click the iTerm icon (it will highlight blue) and copy it by pressing Comand-C.    : � ; ; �   C l i c k   t h e   i T e r m   i c o n   ( i t   w i l l   h i g h l i g h t   b l u e )   a n d   c o p y   i t   b y   p r e s s i n g   C o m a n d - C . 8  < = < l     �� > ?��   > C = Click on this script's icon and paste by pressing Command-V.    ? � @ @ z   C l i c k   o n   t h i s   s c r i p t ' s   i c o n   a n d   p a s t e   b y   p r e s s i n g   C o m m a n d - V . =  A B A l     ��������  ��  ��   B  C D C l     ��������  ��  ��   D  E F E i      G H G I     ������
�� .aevtoappnull  �   � ****��  ��   H k     + I I  J K J O     # L M L Q    " N O P N r     Q R Q l    S���� S c     T U T n     V W V m    ��
�� 
cfol W l    X���� X 4   �� Y
�� 
cwin Y m   	 
���� ��  ��   U m    ��
�� 
TEXT��  ��   R o      ���� 0 
currfolder 
currFolder O R      ������
�� .ascrerr ****      � ****��  ��   P r    " Z [ Z l     \���� \ I    �� ] ^
�� .earsffdralis        afdr ] m    ��
�� afdmdesk ^ �� _��
�� 
rtyp _ m    ��
�� 
TEXT��  ��  ��   [ o      ���� 0 
currfolder 
currFolder M m      ` `�                                                                                  MACS  alis    t  Macintosh HD               Η��H+  	:z
Finder.app                                                     	<�X��(        ����  	                CoreServices    Η��      ���    	:z	:y	:x  6Macintosh HD:System: Library: CoreServices: Finder.app   
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��   K  a�� a I   $ +�� b���� 0 cd_to CD_to b  c d c o   % &���� 0 
currfolder 
currFolder d  e�� e m   & '��
�� boovfals��  ��  ��   F  f g f l     ��������  ��  ��   g  h i h l     �� j k��   j 0 * script run by draging file/folder to icon    k � l l T   s c r i p t   r u n   b y   d r a g i n g   f i l e / f o l d e r   t o   i c o n i  m n m i     o p o I     �� q��
�� .aevtodocnull  �    alis q l      r���� r o      ���� 0 thelist theList��  ��  ��   p k     [ s s  t u t r      v w v m     ��
�� boovfals w o      ���� 0 	newwindow 	newWindow u  x y x X    X z�� { z k    S | |  } ~ } r      �  c     � � � o    ���� 0 thepath thePath � m    ��
�� 
TEXT � o      ���� 0 thepath thePath ~  � � � Z    G � ����� � H     � � l    ����� � D     � � � o    ���� 0 thepath thePath � m     � � � � �  :��  ��   � k   ! C � �  � � � r   ! 2 � � � l  ! 0 ����� � I  ! 0���� �
�� .sysooffslong    ��� null��   � �� � �
�� 
psof � m   # $ � � � � �  : � �� ���
�� 
psin � c   % , � � � l  % * ����� � l  % * ����� � n   % * � � � 1   ( *��
�� 
rvse � n   % ( � � � 2   & (��
�� 
cha  � o   % &���� 0 thepath thePath��  ��  ��  ��   � m   * +��
�� 
TEXT��  ��  ��   � o      ���� 0 x   �  ��� � r   3 C � � � c   3 A � � � l  3 ? ����� � n   3 ? � � � 7  4 ?�� � �
�� 
cha  � m   8 :����  � d   ; > � � l  < = ����� � o   < =���� 0 x  ��  ��   � o   3 4���� 0 thepath thePath��  ��   � m   ? @��
�� 
TEXT � o      ���� 0 thepath thePath��  ��  ��   �  � � � I   H O�� ����� 0 cd_to CD_to �  � � � o   I J���� 0 thepath thePath �  ��� � o   J K���� 0 	newwindow 	newWindow��  ��   �  ��� � l  P S � � � � r   P S � � � m   P Q��
�� boovtrue � o      ���� 0 	newwindow 	newWindow � 0 * create window for any other files/folders    � � � � T   c r e a t e   w i n d o w   f o r   a n y   o t h e r   f i l e s / f o l d e r s��  �� 0 thepath thePath { o    ���� 0 thelist theList y  ��� � L   Y [����  ��   n  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � + % cd to the desired directory in iterm    � � � � J   c d   t o   t h e   d e s i r e d   d i r e c t o r y   i n   i t e r m �  � � � i     � � � I      �� ����� 0 cd_to CD_to �  � � � o      ���� 0 thedir theDir �  ��� � o      ���� 0 	newwindow 	newWindow��  ��   � k     { � �  � � � r      � � � l     ���~ � =     � � � n      � � � 1    �}
�} 
prun � m      � ��                                                                                  ITRM  alis    H  Macintosh HD               Η��H+  	:�	iTerm.app                                                      �G��ɀ�        ����  	                Applications    Η��      ��df    	:�  $Macintosh HD:Applications: iTerm.app   	 i T e r m . a p p    M a c i n t o s h   H D  Applications/iTerm.app  / ��   � m    �|
�| boovtrue�  �~   � o      �{�{ 0 itermrunning itermRunning �  � � � r     � � � c     � � � n     � � � 1    �z
�z 
strq � n     � � � 1   	 �y
�y 
psxp � o    	�x�x 0 thedir theDir � m    �w
�w 
TEXT � o      �v�v 0 thedir theDir �  ��u � O    { � � � k    z � �  � � � I   �t�s�r
�t .miscactvnull��� ��� null�s  �r   �  � � � Z    9 � ��q�p � G    - � � � H    % � � l   $ ��o�n � I   $�m ��l
�m .coredoexnull���     obj  � 4     �k �
�k 
cwin � m    �j�j �l  �o  �n   � l  ( + ��i�h � =   ( + � � � o   ( )�g�g 0 itermrunning itermRunning � m   ) *�f
�f boovfals�i  �h   � I  0 5�e�d�c
�e .aevtrappnull��� ��� null�d  �c  �q  �p   �  � � � l  : :�b�a�`�b  �a  �`   �  ��_ � Q   : z � � � � O   = \ � � � k   C [ � �  � � � r   C J � � � l  C H ��^�] � I  C H�\�[�Z
�\ .Itrmntwnnull���     obj �[  �Z  �^  �]   � o      �Y�Y 0 newtab newTab �  �X  O   K [ I  Q Z�W�V
�W .Itrmsntxnull���     obj �V   �U�T
�U 
Text b   S V m   S T �  c d   o   T U�S�S 0 thedir theDir�T   n   K N	
	 1   L N�R
�R 
Wcsn
 o   K L�Q�Q 0 newtab newTab�X   � 1   = @�P
�P 
Crwn � R      �O�N�M
�O .ascrerr ****      � ****�N  �M   � O   d z I  n y�L�K
�L .Itrmsntxnull���     obj �K   �J�I
�J 
Text b   p u m   p s �  c d   o   s t�H�H 0 thedir theDir�I   n   d k 1   i k�G
�G 
Wcsn l  d i�F�E I  d i�D�C�B
�D .Itrmnwwnnull��� ��� null�C  �B  �F  �E  �_   � m    �                                                                                  ITRM  alis    H  Macintosh HD               Η��H+  	:�	iTerm.app                                                      �G��ɀ�        ����  	                Applications    Η��      ��df    	:�  $Macintosh HD:Applications: iTerm.app   	 i T e r m . a p p    M a c i n t o s h   H D  Applications/iTerm.app  / ��  �u   � �A l     �@�?�>�@  �?  �>  �A       �=�=   �<�;�:
�< .aevtoappnull  �   � ****
�; .aevtodocnull  �    alis�: 0 cd_to CD_to �9 H�8�7�6
�9 .aevtoappnull  �   � ****�8  �7      `�5�4�3�2�1�0�/�.�-�,
�5 
cwin
�4 
cfol
�3 
TEXT�2 0 
currfolder 
currFolder�1  �0  
�/ afdmdesk
�. 
rtyp
�- .earsffdralis        afdr�, 0 cd_to CD_to�6 ,�   *�k/�,�&E�W X  ���l 	E�UO*�fl+ 
 �+ p�*�)�(
�+ .aevtodocnull  �    alis�* 0 thelist theList�)   �'�&�%�$�' 0 thelist theList�& 0 	newwindow 	newWindow�% 0 thepath thePath�$ 0 x   �#�"�!�  �� �������
�# 
kocl
�" 
cobj
�! .corecnte****       ****
�  
TEXT
� 
psof
� 
psin
� 
cha 
� 
rvse� 
� .sysooffslong    ��� null� 0 cd_to CD_to�( \fE�O S�[��l kh ��&E�O�� '*����-�,�&� E�O�[�\[Zk\Z�'2�&E�Y hO*��l+ OeE�[OY��Oh � ��� !�� 0 cd_to CD_to� �"� "  ��� 0 thedir theDir� 0 	newwindow 	newWindow�    ����� 0 thedir theDir� 0 	newwindow 	newWindow� 0 itermrunning itermRunning� 0 newtab newTab!  �����
�	��������� ������
� 
prun
� 
psxp
� 
strq
�
 
TEXT
�	 .miscactvnull��� ��� null
� 
cwin
� .coredoexnull���     obj 
� 
bool
� .aevtrappnull��� ��� null
� 
Crwn
� .Itrmntwnnull���     obj 
� 
Wcsn
� 
Text
�  .Itrmsntxnull���     obj ��  ��  
�� .Itrmnwwnnull��� ��� null� |��,e E�O��,�,�&E�O� f*j O*�k/j 
 �f �& 
*j 	Y hO $*�, *j E�O��, *��%l UUW X  *j �, *�a �%l UU ascr  ��ޭ