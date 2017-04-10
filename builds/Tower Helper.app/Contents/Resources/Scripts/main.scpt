JsOsaDAS1.001.00bplist00�Vscripto	 / /   T h e   g o a l   o f   t h i s   s c r i p t   i s   t o   a u t o m a t e   s e t t i n g   a   c e r t a i n   v a l u e   i n   t h e   c o m m i t   f i e l d   o f   A p p l i c a t i o n s   s u c h   a s   T o w e r   o r   S o u r c e T r e e . 
 / /   T h i s   s c r i p t   w i l l   e x t r a c t   a   J i r a   t i c k e t   n a m e   f r o m   t h e   c u r r e n t l y   a c t i v e   b r a n c h   a n d   p r e - f i l l   t h e   c o m m i t   f i e l d   w i t h   t h e   t i c k e t   n a m e . 
 
 
 / /   C o n f i g u r a b l e   p r o p e r t i e s 
 
 v a r   s u p p o r t e d A p p l i c a t i o n s   =   { 	 	 	 	 	 	 	 	 / /   T h e   a p p l i c a t i o n   n a m e   a s   s h o w n   i n   t h e   m e n u   b a r   w h e n   b e i n g   r u n 
 	 T O W E R :   ' T o w e r ' , 
 	 S O U R C E T R E E :   ' S o u r c e T r e e ' 
 } 
 v a r   c u r r e n t A p p l i c a t i o n   =   s u p p o r t e d A p p l i c a t i o n s . T O W E R 	 	 / /   T h e   a p p l i c a t i o n   f o r   w h i c h   t h e   s c r i p t   s h o u l d   r u n 
 v a r   d e b u g M o d e   =   f a l s e 	 	 	 	 	 	 	 	 	 	 / /   W h e n   e n a b l e d ,   e r r o r   m e s s a g e s   w i l l   b e   s h o w n   i n   a   d i a l o g   m e s s a g e 
 v a r   r e f r e s h I n t e r v a l   =   0 . 5 	 	 	 	 	 	 	 	 	 / /   N u m b e r   o f   s e c o n d s   b e t w e e n   e a c h   r e f r e s h   i n t e r v a l 
 v a r   t i c k e t P r o p e r t i e s   =   { 	 	 	 	 	 	 	 	 	 / /   V a r i o u s   p r o p e r t i e s   w h i c h   d e s c r i b e   t h e   J i r a   t i c k e t   n a m e   ( e . g .   T M A - 1 9 5 2 ) 
 	 p r e f i x :   ' T M A ' , 
 	 d e l i m i t e r :   ' - ' , 
 	 n u m b e r O f D i g i t s :   4 
 } 
 
 
 / /   H a n d l e r s 
 
 f u n c t i o n   r u n ( )   { 
 	 t r y P r e f i l l i n g C o m m i t M e s s a g e ( ) 
 } 
 
 f u n c t i o n   i d l e ( )   { 
 	 t r y P r e f i l l i n g C o m m i t M e s s a g e ( ) 
         r e t u r n   r e f r e s h I n t e r v a l 
 } 
 
 
 / /   S c r i p t   s t a r t i n g   p o i n t 
 
 f u n c t i o n   t r y P r e f i l l i n g C o m m i t M e s s a g e ( )   { 
 	 t r y   { 
 	 	 l e t   c o m m i t F i e l d   =   g e t C o m m i t F i e l d F o r A p p l i c a t i o n W i t h N a m e ( c u r r e n t A p p l i c a t i o n ) 
 	 	 l e t   b r a n c h N a m e   =   g e t A c t i v e B r a n c h N a m e F o r A p p l i c a t i o n W i t h N a m e ( c u r r e n t A p p l i c a t i o n ) 
 	 	 l e t   t i c k e t N a m e   =   g e t T i c k e t N a m e F r o m B r a n c h N a m e ( b r a n c h N a m e ,   t i c k e t P r o p e r t i e s ) 
 	 	 p r e f i l l C o m m i t F i e l d W i t h M e s s a g e ( t i c k e t N a m e ,   c o m m i t F i e l d ) 
 	 }   c a t c h   ( e r r o r )   { 
 	 	 h a n d l e E r r o r ( e r r o r ) 
 	 } 
 } 
 
 
 / /   C o m m i t   f i e l d   h a n d l i n g 
 
 f u n c t i o n   p r e f i l l C o m m i t F i e l d W i t h M e s s a g e ( m e s s a g e ,   c o m m i t F i e l d )   { 
 	 i f   ( ! m e s s a g e   | |   ! c o m m i t F i e l d . e x i s t s ( ) )   {   r e t u r n   } 
 	 i f   ( c o m m i t F i e l d . v a l u e ( ) . l e n g t h   = =   0   | |   c o m m i t F i e l d . v a l u e ( ) . i n c l u d e s ( m e s s a g e ) )   {   r e t u r n   } 
 	 
 	 c o m m i t F i e l d . v a l u e   =   ` $ { m e s s a g e } :   `   +   c o m m i t F i e l d . v a l u e ( ) 
 } 
 
 f u n c t i o n   g e t C o m m i t F i e l d F o r A p p l i c a t i o n W i t h N a m e ( n a m e )   { 
 	 c o n s t   a p p l i c a t i o n V i e w   =   g e t A p p l i c a t i o n V i e w F o r A p p l i c a t i o n W i t h N a m e ( n a m e ) 
 	 
 	 s w i t c h   ( n a m e )   { 
 	 
 	 	 c a s e   s u p p o r t e d A p p l i c a t i o n s . T O W E R : 
 	 	 	 r e t u r n   a p p l i c a t i o n V i e w . w i n d o w s [ 0 ] . s p l i t t e r G r o u p s [ 0 ] . s p l i t t e r G r o u p s [ 0 ] . t e x t F i e l d s [ 1 ] 
 	 	 	 b r e a k 
 	 	 	 
 	 	 c a s e   s u p p o r t e d A p p l i c a t i o n s . S O U R C E T R E E : 
 	 	 	 r e t u r n   a p p l i c a t i o n V i e w . w i n d o w s [ 0 ] . s p l i t t e r G r o u p s [ 0 ] . s p l i t t e r G r o u p s [ 0 ] . s p l i t t e r G r o u p s [ 0 ] . s c r o l l A r e a s [ 0 ] . t e x t A r e a s [ 0 ] 
 	 	 	 b r e a k 
 	 	 	 
 	 	 d e f a u l t : 
 	 	 	 r e t u r n   n u l l 
 	 } 
 } 
 
 
 / /   B r a n c h   n a m e   h a n d l i n g 
 
 f u n c t i o n   g e t A c t i v e B r a n c h N a m e F o r A p p l i c a t i o n W i t h N a m e ( n a m e )   { 
 	 c o n s t   a p p l i c a t i o n V i e w   =   g e t A p p l i c a t i o n V i e w F o r A p p l i c a t i o n W i t h N a m e ( n a m e ) 
 	 
 	 s w i t c h   ( n a m e )   { 
 	 
 	 	 c a s e   s u p p o r t e d A p p l i c a t i o n s . T O W E R : 
 	 	 	 r e t u r n   a p p l i c a t i o n V i e w . w i n d o w s [ 0 ] . s p l i t t e r G r o u p s [ 0 ] . s p l i t t e r G r o u p s [ 0 ] . b u t t o n s [ 0 ] . t i t l e ( ) 
 	 	 	 b r e a k 
 	 	 	 
 	 	 c a s e   s u p p o r t e d A p p l i c a t i o n s . S O U R C E T R E E : 
 	 	 	 r e t u r n   a p p l i c a t i o n V i e w . w i n d o w s [ 0 ] . s p l i t t e r G r o u p s [ 0 ] . s p l i t t e r G r o u p s [ 0 ] . s p l i t t e r G r o u p s [ 0 ] . c h e c k b o x e s [ 0 ] . t i t l e ( ) 
 	 	 	 b r e a k 
 	 	 	  
 	 	 d e f a u l t : 
 	 	 	 r e t u r n   n u l l 
 	 } 
 } 
 
 f u n c t i o n   g e t T i c k e t N a m e F r o m B r a n c h N a m e ( b r a n c h N a m e ,   t i c k e t P r o p e r t i e s )   { 
 	 c o n s t   r e g E x   =   ` $ { t i c k e t P r o p e r t i e s . p r e f i x } $ { t i c k e t P r o p e r t i e s . d e l i m i t e r } [ 0 - 9 ] { $ { t i c k e t P r o p e r t i e s . n u m b e r O f D i g i t s } } ` 
 	 c o n s t   m a t c h e s   =   b r a n c h N a m e . m a t c h ( r e g E x ) 
 	 r e t u r n   ( m a t c h e s   & &   m a t c h e s . l e n g t h   >   0   ?   m a t c h e s [ 0 ]   :   n u l l ) 
 } 
 
 
 / /   H e l p e r   f u n c t i o n s 
 
 f u n c t i o n   g e t A p p l i c a t i o n V i e w F o r A p p l i c a t i o n W i t h N a m e ( n a m e )   { 
 	 r e t u r n   A p p l i c a t i o n ( ' S y s t e m   E v e n t s ' ) . p r o c e s s e s [ n a m e ] 
 } 
 
 
 / /   E r r o r   h a n d l i n g 
 
 f u n c t i o n   h a n d l e E r r o r ( e r r o r )   { 
 	 i f   ( ! d e b u g M o d e )   {   r e t u r n   }   / /   I f   n o t   i n   d e b u g   m o d e :   f a i l   s i l e n t l y 
 	 d i s p l a y D i a l o g W i t h M e s s a g e ( ` O h   n o ,   s o m e t h i n g   w e n t   w r o n g  �=�& \ n \ n&��   E R R O R \ n $ { e r r o r . m e s s a g e } \ n \ n $ { e r r o r . s t a c k } ` ) 
 } 
 
 f u n c t i o n   d i s p l a y D i a l o g W i t h M e s s a g e ( m e s s a g e T o D i s p l a y )   { 
 	 c o n s t   a p p   =   A p p l i c a t i o n . c u r r e n t A p p l i c a t i o n ( ) 
 	 a p p . i n c l u d e S t a n d a r d A d d i t i o n s   =   t r u e 
         a p p . d i s p l a y D i a l o g ( m e s s a g e T o D i s p l a y ,   {   b u t t o n s :   [ " O k " ]   } ) 
 }                              (jscr  ��ޭ