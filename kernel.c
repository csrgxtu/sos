void main() {
    // create a pointer to a char, and point it to the first text cell of
    // vid mem: the top left of the screen
    char* video_memory = (char*) 0xb8000;
    // at the add pointed by vid mem, store the char 'x'
    *video_memory = 'X';
}