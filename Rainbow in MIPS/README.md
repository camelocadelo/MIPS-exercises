1. Use the procedure set pixel color to implement a procedure drawRainbow in
MIPS assembly language that draws a semicircle. drawRainbow should take the x
and y coordinates of the center of semicircle (in $a0 and $a1), the radius (in $a2),
and the color of circle (in $a3) as inputs.
The signature of this procedure in Java would look like this: void drawRainbow(int
x, int y, int radius, int color).
Then, in your program, call drawRainbow in a loop to draw 7 semicircles. At each
iteration the radius of semicircle should be reduced by 1 and the color should be
changed to another color. Start your loop with a radius of 15 and stop when radius
= 9 (including 9). Set both the width and height of your display to 64. Set the
center of your semicircles to (32, 32).
In your Bitmap Display tool, set Unit Width, Unit Height, Display Width, and
Display Height to 4, 4, 256, and 256, respectively. Do not forget to follow the MIPS
convention.
