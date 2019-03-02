he value of every byte and write the modified values) using four parameters, int
arrSize, int stepSize, int repCount and int loopSize. Use the MIPS conventions to
pass the parameters.
The signature of this procedure in C would look like this:

void myMemoryUpdate (int repCount, int loopSize, int arrSize, int stepSize){
// an array type could be different (e.g.,, char array[arrSize]; )
for (int repIdx=0; repIdx < repCount ; repIdx ++){
 for (int index = 0; index < arrSize; index += stepSize) {
 // do read, add one in every byte and write
 //e.g., array[index] = array[index] + 1; // for char type, stepSize =1
 }
}
