An implementation of the 8-neighbor 2D cellular automata that can accept an arbitrary binary ruleset. Written in 3 lines of J.

The magic happens on lines 7-9, all the rest is mostly user interaction.

Open it in the J console.

Nothing sould appear, this is normal, if you want a totally random CA with random rules and random starting positions then type in 'GO XXX' (without quotes) XXX being the amount of generations you want. (ex: GO 15)

If you want to have some parameters to set, type in "Choices ''" (without the double quotes, and with the single quotes), and just follow the instructions

Now J saves arrays in a binary form, so it you were to open up input.txt, it is mostly unprintible characters. However, if you use the read from file option, it is obvious that the configuration is not random.

To read the array from the file without running though the script, type 'binarr fread File'

To create your own starting position, use this format inside the console  'Y Y $ X X X X X X X X X X X X X' Y's being the size of the array, and X's being the individual bits, and the $ being the 'shape of' operator. When you are satisfied with the configuration assign it to a varible 'Variable =: Y Y $ X X X X X' and then write it to the file, 'arrbin Variable fwrite File'. arrbin is the function to make it suitable to write the array to file (you can see its output by only calling 'arrbin Variable'), fwrite is a funtion that take the left side of it and writes it to the right side, which is the File, which has been preassigned it's name inside the script already (open the console by right clicking the file, makes thing so much easier).

Developed for Windows, completely untested on anything else.
