#include <stdio.h>
#include <string.h>
#include <conio.h>
#include "user.h"
#include "game.h"

void initUserSystem(UserSystem *system) {
    system->userCount = 0;
}

void saveUserSystem(UserSystem *system) {
    FILE *fp = fopen("users.dat", "wb");
    if (fp != NULL) {
        fwrite(system, sizeof(UserSystem), 1, fp);
        fclose(fp);
    }
}

void loadUserSystem(UserSystem *system) {
    FILE *fp = fopen("users.dat", "rb");
    if (fp == NULL) {
        initUserSystem(system);
    } else {
        fread(system, sizeof(UserSystem), 1, fp);
        fclose(fp);
    }
}

User* findUser(UserSystem *system, const char *username) {
    for (int i = 0; i < system->userCount; i++) {
        if (strcmp(system->users[i].username, username) == 0) {
            return &system->users[i];
        }
    }
    return NULL;
}

User* loginUser(UserSystem *system) {
    char username[MAX_USERNAME_LEN];
    clearScreen();
    printf("用户登录\n");
    printf("========\n\n");
    printf("请输入用户名: ");
    scanf("%s", username);
    while (getchar() != '\n'); // 清除输入缓冲
    
    User* user = findUser(system, username);
    if (user == NULL) {
        if (system->userCount >= MAX_USERS) {
            printf("\n用户数量已达上限！按任意键返回...");
            _getch();
            return NULL;
        }
        
        printf("\n新用户，是否创建账号？(y/n): ");
        char choice = _getch();
        if (choice == 'y' || choice == 'Y') {
            user = &system->users[system->userCount++];
            strncpy(user->username, username, MAX_USERNAME_LEN - 1);
            user->username[MAX_USERNAME_LEN - 1] = '\0';
            user->highScore = 0;
            saveUserSystem(system);
            printf("\n\n账号创建成功！按任意键继续...");
            _getch();
        } else {
            return NULL;
        }
    } else {
        printf("\n登录成功！历史最高分：%d\n", user->highScore);
        printf("\n按任意键继续...");
        _getch();
    }
    
    return user;
}

void updateUserScore(UserSystem *system, const char *username, int score) {
    User* user = findUser(system, username);
    if (user != NULL && score > user->highScore) {
        user->highScore = score;
        saveUserSystem(system);
    }
} 