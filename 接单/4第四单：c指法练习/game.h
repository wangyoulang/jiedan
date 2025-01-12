#ifndef GAME_H
#define GAME_H

#include "user.h"

#define WINDOW_WIDTH 80
#define WINDOW_HEIGHT 25
#define GAME_COLS 20    // 游戏区域列数
#define INFO_COLS 20    // 信息显示区域列数

typedef struct {
    int slow_speed;
    int medium_speed;
    int fast_speed;
    int score_to_medium;   // 100分进入中速
    int score_to_fast;     // 200分进入快速
    int win_score;         // 250分通关
} GameSettings;

typedef struct {
    char character;
    int row;
    int col;
    int active;
} FallingChar;

typedef struct {
    char screen[WINDOW_HEIGHT][WINDOW_WIDTH];
} GameScreen;

void loadSettings(GameSettings *settings);
void saveSettings(GameSettings *settings);
void configureSettings(GameSettings *settings);
void startGame(const char *username, GameSettings *settings, UserSystem *userSystem, int initialSpeed);
void loginAndPlay(GameSettings *settings);
void clearScreen(void);
void gotoxy(int x, int y);
void hideCursor(void);
void drawGame(GameScreen *screen, const char *username, int score, int currentSpeed);
void initScreen(GameScreen *screen);

#endif 