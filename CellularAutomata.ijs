generateNewCA =: 4 : '(x, y)$?(x*y)$2'						NB. Generate random x by y grid of bits 0 inclusive to 2 noninclusive

RandomCA =: generateNewCA /20 20						NB. Generate Random CA of size 20 20
RuleKeys =: (1 < ;. 3 (#: i. 32))						NB. Generate Keys 00000 to 11111
RandomRules =: RuleKeys,.(,.(1<;.1(32$?32$2)))					NB. If called appends random values to keys

CABoxedUpWithNeighbors =: 3 : '<"2]0 2|:_1 0 1|."0 _"_ 1] _1 0 1 |."0 _ y'	NB. For each cell create its own array and populate it with its neighbors. This is accomplished by creating copies of each row, shiting them 1 forward, 1 backward, then rotating the result, agian shifing backwards and forwards, then transposing it onto another array, each cell in the previous array now is in their own seperate array surrounded by copies of it neighbors.
GetRuleSetForCurrentCA =: 3 : '(<(<1;1),(<0;1),(<1;2),(<2;1),(<1;0)){each y'	NB. For each 3x3 array in this new array get the get the cell itself (<1;1), north (<0;1), east (<1;2), etc, and append their values together, then put them in a new array ready to be grabbed ad the key to the ruleset.f 
MakeNextStateWith =: 4 : ',.>(<(#.>> { each (x)) ; 1) { y'			NB. For each value in this array, grab the value in the ruleset key-value array and then place that value in a new array. 

display =: (1!:2) & 2	 	       	      				NB. Making print line easyer to read.
File =: 'input.txt'								NB. The file to grab starting position, if needed.
binarr =: 3!:2									NB. Function to convert binary data in file to array
arrbin  =: 3!:1								NB. Function to convert array to binary, suitable for saving in files. 

CreateNextGeneration =: 4 : 0							NB. A dyadic verb (4 : 0) that takes an array as y and a rule set as x
NeighborGrid =. CABoxedUpWithNeighbors y					NB. Creates grid of all cells surrounded by copies of their neighbors
RuleSetGrid =. GetRuleSetForCurrentCA NeighborGrid				NB. Generates key array for ruleset key value array.
NextCA =. RuleSetGrid MakeNextStateWith x					NB. Generates Next array with key array and passed in ruleset
)

GO =: 3 : 0									NB. A monadic verb (3 : 0) that takes the number of generations at y
InnerCA =. RandomCA								NB. Makes local copy of random array
Rules =. RandomRules								NB. Local copy of random rules
display 'Generation'
display 0
display ''
display InnerCA
display ''
generation =. 1
while. (y>0)									NB. While passed in value(generation count) is greater than zero
 do.
     NextCA =. Rules CreateNextGeneration InnerCA				NB. Generate next generation
	 display 'Generation'
	 display generation
	 generation =. generation + 1						NB. Printing and upkeep for printed variables, as well as generation variable
	 y =. y - 1
	 InnerCA =. NextCA
	 display ''
	 display NextCA
	 display ''
end.
)


Choices =: 3 : 0
index =. 31									NB. Ruleset index, arrays start at 0
Rules =. RuleKeys								NB. Generate Just the Keys, you will be adding in the values
display 'Welcome to the CA creator!!'
display 'Rules is ordered by Cell, North, East, South, West.'
while. (index > _1)								NB. Ohh off by ones..
 do.
     display 'Please enter rule for.'
     display (<index;0) { Rules
	 display '(C N E S W)'
	 input =. (1!:1) 1							NB. Grab user input
	NB. while. (input > 1 *./ input < 0)
	NB.   do.
	NB.	display 'Please enter a valid choice(0/1):'			NB. Fail error checking code..
	NB.	input =. (1!:1) 1
	NB. end.
	 if. (index = 31)							NB. If this is first time through this loop
	  do.
		input =. ".input
		inputIndex =. ,. (<input)					NB. Create value array
		index =. index - 1
	 elseif. (index < 31)							NB. Else
		do.
		 input =. ".input
		 inputIndex =. inputIndex ,. (<input)				NB. Append to existing array
		 index =. index - 1
	 end.
 end.
Rules =. Rules ,. (|: inputIndex)						NB. Transpose rule value array, and append to rule key array
display 'Alright, now, would you like to use a file for input?'
display 'Y/N (1/0)'
fileInput =. (1!:1) 1
if. (fileInput = '1')
 do.
	InnerCA =. binarr fread 'input.txt'					NB. Convert array from binary from to usable form
elseif. (fileInput = '0')
 do.
	display 'How big would you like the X coordinate to be?'
	xInput =. (1!:1) 1
	display 'And the Y axis?'
	yInput =. (1!:1) 1							NB. Setup questions
	display 'Random configurating genertaing now.'
	xInput =. ".xInput							NB. Because input is char, turn it into int
	yInput =. ".yInput
	InnerCA =. xInput generateNewCA yInput
 end.
display 'Would you like to drive, or automatic?(0/1)'
driveInput =. (1!:1) 1
driveInput =. ".driveInput
if. (driveInput = 0) do. Rules Driving InnerCA					NB. If you are driving of the computer is doing it for you, it still passes in the same stuff
elseif. (driveInput = 1) do. Rules Automatic InnerCA end.
)

Driving =: 4 : 0
InnerCA =. y
Rules =. x
display 'Alright, so, to exit enter in E, to generate next enter any key'
display 'Generation'
display 0
display ''
display InnerCA
display ''
generations =. 1
forwardInput =. (1!:1) 1
while.(forwardInput ~: 'E')							NB. While key entered is not "E" for exit, then generate next generation
 do.
	NextCA =. Rules CreateNextGeneration InnerCA
	display 'Generation'
	display generations
	generations =. generations + 1
	InnerCA =. NextCA
	display ''
	display NextCA
	display ''
	forwardInput =. (1!:1) 1
 end.
)

Automatic =: 4 : 0
InnerCA =. y									NB. Passes in variables
Rules =. x
display 'How many Generations?'						NB. Because we can be having ourselves an infinate loop, we get generation count.
generations =. (1!:1) 1
generations =. ".generations
generationsIndex =. 1
display 'Generation'
display 0
display ''
display InnerCA
display ''
while. (generations>0)
 do. 
	NextCA =. Rules CreateNextGeneration InnerCA				NB. Generate them generations
	display 'Generation'
	display generationsIndex
	generations =. generations - 1
	generationsIndex =. generationsIndex + 1
	InnerCA =. NextCA
	display ''
	display NextCA
	display ''
 end.
 )