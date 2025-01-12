#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <windows.h>
#include <conio.h>
#include "game.h"
#include "user.h"

void loadSettings(GameSettings *settings) {
    FILE *fp = fopen("settings.dat", "rb");
    if (fp == NULL) {
        // 速度固定
        settings->slow_speed = 500;    // 慢速 500ms
        settings->medium_speed = 300;  // 中速 300ms
        settings->fast_speed = 100;    // 快速 100ms
        // 默认分数设置
        settings->score_to_medium = 100;  // 100分进入中速
        settings->score_to_fast = 200;    // 200分进入快速
        settings->win_score = 250;        // 250分通关
        saveSettings(settings);
    } else {
        fread(settings, sizeof(GameSettings), 1, fp);
        // 确保速度值始终固定
        settings->slow_speed = 500;
        settings->medium_speed = 300;
        settings->fast_speed = 100;
        fclose(fp);
    }
}

void saveSettings(GameSettings *settings) {
    FILE *fp = fopen("settings.dat", "wb");
    if (fp != NULL) {
        fwrite(settings, sizeof(GameSettings), 1, fp);
        fclose(fp);
    }
}

void clearScreen(void) {
    system("cls");
}

void gotoxy(int x, int y) {
    COORD coord;
    coord.X = x;
    coord.Y = y;
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), coord);
}

void hideCursor(void) {
    CONSOLE_CURSOR_INFO cursor_info = {1, 0};
    SetConsoleCursorInfo(GetStdHandle(STD_OUTPUT_HANDLE), &cursor_info);
}

void initScreen(GameScreen *screen) {
    for (int i = 0; i < WINDOW_HEIGHT; i++) {
        for (int j = 0; j < WINDOW_WIDTH; j++) {
            if (j < GAME_COLS) {
                screen->screen[i][j] = ' ';
            } else if (j == GAME_COLS) {
                screen->screen[i][j] = '|';
            } else {
                screen->screen[i][j] = ' ';
            }
        }
    }
}

void drawGame(GameScreen *screen, const char *username, int score, int currentSpeed) {
    static int lastScore = -1;
    static int lastSpeed = -1;
    
    // 只在第一次或分数/速度变化时更新信息区域
    if (lastScore == -1 || lastScore != score || lastSpeed != currentSpeed) {
        gotoxy(GAME_COLS + 2, 1);
        printf("玩家: %s", username);
        gotoxy(GAME_COLS + 2, 2);
        printf("得分: %d", score);
        gotoxy(GAME_COLS + 2, 3);
        printf("速度: %d ms", currentSpeed);
        
        lastScore = score;
        lastSpeed = currentSpeed;
    }
    
    // 只更新游戏区域
    for (int i = 0; i < WINDOW_HEIGHT; i++) {
        gotoxy(0, i);
        for (int j = 0; j <= GAME_COLS; j++) { // 只绘制到分隔线
            putchar(screen->screen[i][j]);
        }
    }
}

void startGame(const char *username, GameSettings *settings, UserSystem *userSystem, int initialSpeed) {
    int score = 0;
    int currentSpeed = initialSpeed;  // 先用初始速度
    FallingChar chars[GAME_COLS];
    int playerPos = GAME_COLS / 2;
    GameScreen screen;
    
    // 初始化
    srand(time(NULL));
    clearScreen();
    hideCursor();
    initScreen(&screen);
    
    // 初始化掉落字符
    for (int i = 0; i < GAME_COLS; i++) {
        chars[i].active = 0;
    }
    
    // 游戏主循环
    DWORD lastDropTime = GetTickCount();
    
    while (1) {
        // 根据分数更新当前速度
        if (score >= settings->score_to_fast) {
            currentSpeed = settings->fast_speed;
        } else if (score >= settings->score_to_medium) {
            currentSpeed = settings->medium_speed;
        }
        
        DWORD currentTime = GetTickCount();
        
        // 更新屏幕内容
        initScreen(&screen);
        
        // 绘制掉落的字符
        for (int i = 0; i < GAME_COLS; i++) {
            if (chars[i].active) {
                screen.screen[chars[i].row][chars[i].col] = chars[i].character;
            }
        }
        
        // 绘制玩家挡板
        screen.screen[WINDOW_HEIGHT-1][playerPos] = '-';
        
        // 绘制游戏画面
        drawGame(&screen, username, score, currentSpeed);
        
        // 每隔一定时间添加随机字符
        if (currentTime - lastDropTime >= currentSpeed) {
            // 添加随机字符
            if (rand() % 10 == 0) {
                int col = rand() % GAME_COLS;
                if (!chars[col].active) {
                    chars[col].active = 1;
                    chars[col].row = 0;
                    chars[col].col = col;
                    chars[col].character = 'A' + (rand() % 26);
                }
            }
            
            // 处理字符下落
            for (int i = 0; i < GAME_COLS; i++) {
                if (chars[i].active) {
                    chars[i].row++;
                    if (chars[i].row >= WINDOW_HEIGHT - 1) {
                        if (i == playerPos) {
                            // 游戏结束
                            // 更新最高分
                            if (score > 0) {
                                updateUserScore(userSystem, username, score);
                            }
                            gotoxy(0, WINDOW_HEIGHT + 1);
                            printf("游戏结束！最终得分：%d\n", score);
                            Sleep(2000);
                            return;
                        }
                        chars[i].active = 0;
                    }
                }
            }
            
            lastDropTime = currentTime;
        }
        
        // 处理键盘输入 - 更频繁地检查
        while (_kbhit()) {
            unsigned char key = _getch();
            switch (key) {
                case 0xE0: // 方向键的前导字符 (224 的十六进制)
                    key = _getch();
                    switch (key) {
                        case 72: // 上箭头
                            break;
                        case 80: // 下箭头
                            break;
                        case 75: // 左箭头
                            if (playerPos > 0) playerPos--;
                            break;
                        case 77: // 右箭头
                            if (playerPos < GAME_COLS - 1) playerPos++;
                            break;
                    }
                    break;
                default:
                    // 检查是否击中字符
                    if (chars[playerPos].active && 
                        (key == chars[playerPos].character || 
                         key == chars[playerPos].character + 32)) { // 支持大小写
                        score += 10;
                        chars[playerPos].active = 0;
                        
                        // 检查是否需要提升速度或通关
                        if (score >= settings->win_score) {
                            // 更新最高分
                            if (score > 0) {
                                updateUserScore(userSystem, username, score);
                            }
                            gotoxy(0, WINDOW_HEIGHT + 1);
                            printf("恭喜通关！最终得分：%d\n", score);
                            printf("按任意键返回主菜单...");
                            _getch();
                            return;
                        } else if (score == settings->score_to_fast) {  // 刚好达到快速模式分数
                            gotoxy(0, WINDOW_HEIGHT + 1);
                            printf("进入快速模式！");
                            Sleep(1000);
                            gotoxy(0, WINDOW_HEIGHT + 1);
                            printf("                ");
                        } else if (score == settings->score_to_medium) {  // 刚好达到中速模式分数
                            gotoxy(0, WINDOW_HEIGHT + 1);
                            printf("进入中速模式！");
                            Sleep(1000);
                            gotoxy(0, WINDOW_HEIGHT + 1);
                            printf("                ");
                        }
                    }
                    break;
            }
        }
        
        // 控制刷新率
        Sleep(10); // 约100FPS的刷新率
    }
}

void configureSettings(GameSettings *settings) {
    while (1) {
        clearScreen();
        printf("游戏设置\n");
        printf("========\n\n");
        printf("分数设置：\n");
        printf("1. 进入中速的分数 (当前: %d)\n", settings->score_to_medium);
        printf("2. 进入快速的分数 (当前: %d)\n", settings->score_to_fast);
        printf("3. 通关分数 (当前: %d)\n", settings->win_score);
        printf("4. 返回主菜单\n");
        printf("\n请选择要修改的选项 (1-4): ");
        
        char choice = _getch();
        int *value_to_change = NULL;
        const char *prompt = NULL;
        
        switch (choice) {
            case '1':
                value_to_change = &settings->score_to_medium;
                prompt = "进入中速的分数";
                break;
            case '2':
                value_to_change = &settings->score_to_fast;
                prompt = "进入快速的分数";
                break;
            case '3':
                value_to_change = &settings->win_score;
                prompt = "通关分数";
                break;
            case '4':
                return;
            default:
                continue;
        }
        
        clearScreen();
        printf("修改%s\n", prompt);
        printf("==============\n\n");
        printf("当前值: %d\n", *value_to_change);
        printf("\n请输入新的值 (0-1000): ");
        
        char input[10];
        fgets(input, sizeof(input), stdin);
        input[strcspn(input, "\n")] = 0;
        
        int new_value = atoi(input);
        if (new_value < 0 || new_value > 1000) {
            printf("\n输入值必须在 0-1000 之间！按任意键重试...");
            _getch();
            continue;
        }
        
        printf("\n您输入的新值是: %d", new_value);
        printf("\n确认修改吗？(y/n): ");
        
        char confirm = _getch();
        if (confirm == 'y' || confirm == 'Y') {
            *value_to_change = new_value;
            saveSettings(settings);
            printf("\n\n设置已保存！按任意键继续...");
            _getch();
        }
    }
}

void loginAndPlay(GameSettings *settings) {
    static UserSystem userSystem;
    static int initialized = 0;
    
    if (!initialized) {
        loadUserSystem(&userSystem);
        initialized = 1;
    }
    
    User* user = loginUser(&userSystem);
    if (user != NULL) {
        while (1) {
            clearScreen();
            printf("选择游戏速度\n");
            printf("============\n\n");
            printf("1. 慢速模式 (500 ms)\n");
            printf("2. 中速模式 (300 ms)\n");
            printf("3. 快速模式 (100 ms)\n");
            printf("\n请选择开始的速度 (100-500): ");
            
            char input[10];
            fgets(input, sizeof(input), stdin);
            
            // 去除换行符
            input[strcspn(input, "\n")] = 0;
            
            int initialSpeed;
            
            // 检查是否是数字输入
            if (isdigit(input[0])) {
                initialSpeed = atoi(input);
                if (initialSpeed < 100 || initialSpeed > 1000) {
                    printf("\n速度值必须在 100-1000 ms 之间！按任意键重试...");
                    _getch();
                    continue;
                }
            } else {
                // 按模式选择
                switch (input[0]) {
                    case '1':
                        initialSpeed = 500;  // 慢速
                        break;
                    case '2':
                        initialSpeed = 300;  // 中速
                        break;
                    case '3':
                        initialSpeed = 100;  // 快速
                        break;
                    default:
                        continue;
                }
            }
            
            startGame(user->username, settings, &userSystem, initialSpeed);
            break;
        }
    }
} 