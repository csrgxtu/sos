#include "../drivers/screen.h"

void main() {
    clear_screen();
    kprint_at("Hello World From C!", 30, 12);
}