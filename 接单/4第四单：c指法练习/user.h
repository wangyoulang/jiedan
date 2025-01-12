#ifndef USER_H
#define USER_H

#define MAX_USERNAME_LEN 50
#define MAX_USERS 100

// 前向声明
void clearScreen(void);

typedef struct {
    char username[MAX_USERNAME_LEN];
    int highScore;
} User;

typedef struct {
    User users[MAX_USERS];
    int userCount;
} UserSystem;

void initUserSystem(UserSystem *system);
void saveUserSystem(UserSystem *system);
void loadUserSystem(UserSystem *system);
User* findUser(UserSystem *system, const char *username);
User* loginUser(UserSystem *system);
void updateUserScore(UserSystem *system, const char *username, int score);

#endif 