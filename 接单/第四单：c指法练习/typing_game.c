#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <windows.h>
#include "game.h"
#include "user.h"

int main() {
    // 设置控制台编码为UTF-8
    SetConsoleOutputCP(65001);
    SetConsoleCP(65001);
    
    // 设置控制台字体
    CONSOLE_FONT_INFOEX cfi;
    cfi.cbSize = sizeof(cfi);
    cfi.nFont = 0;
    cfi.dwFontSize.X = 0;
    cfi.dwFontSize.Y = 16;
    cfi.FontFamily = FF_DONTCARE;
    cfi.FontWeight = FW_NORMAL;
    wcscpy(cfi.FaceName, L"新宋体");
    SetCurrentConsoleFontEx(GetStdHandle(STD_OUTPUT_HANDLE), FALSE, &cfi);
    
    // 初始化游戏设置
    GameSettings settings;
    loadSettings(&settings);
    
    while (1) {
        clearScreen();  // 添加这行使显示更清晰
        printf("\n打字练习游戏\n");
        printf("==========\n\n");
        printf("1. 开始游戏\n");
        printf("2. 游戏设置\n");
        printf("3. 退出\n\n");
        printf("请选择: ");
        
        char choice = _getch();
        
        switch (choice) {
            case '1':
                loginAndPlay(&settings);
                break;
            case '2':
                configureSettings(&settings);
                break;
            case '3':
                return 0;
        }
    }
    
    return 0;
} 