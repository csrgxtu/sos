void clean_screen() {
    char* vid_mem = (char*) 0xb8000;
    for (int idx = 0; idx < 25; idx++) {
        for (int jdx = 0; jdx < 80; jdx++) {
            *vid_mem = ' ';
            vid_mem += 2;
        }
    }
}

void main() {
    // create a pointer to a char, and point it to the first text cell of
    // vid mem: the top left of the screen
    char* video_memory = (char*) 0xb8000;

    clean_screen();
    char welcome_msg[] = "Hello World From Clang";
    for (int idx = 0; idx < 22; idx++) {
        *video_memory = welcome_msg[idx];
        video_memory += 2;
    }
}