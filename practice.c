#include <windows.h>

int main(void) {
    MessageBoxW(
        NULL,
        L"Hello World!",
        L"My first messagebox!",
        MB_YESNOCANCEL | MB_ICONEXCLAMATION
    );
    return EXIT_SUCCESS;
}