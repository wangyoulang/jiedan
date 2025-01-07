package org.com.facecheckin.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.com.facecheckin.entity.User;
import org.com.facecheckin.service.UserService;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Api(tags = "用户管理")
@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @ApiOperation("用户注册")
    @PostMapping("/register")
    public Object register(@RequestBody User user) {
        return userService.register(user);
    }

    @ApiOperation("用户登录")
    @PostMapping("/login")
    public Object login(@RequestParam String username, @RequestParam String password) {
        return userService.login(username, password);
    }

    @ApiOperation("上传人脸图片")
    @PostMapping("/{userId}/face")
    public Object uploadFace(@PathVariable Long userId, @RequestParam("file") MultipartFile file) {
        return userService.uploadFace(userId, file);
    }

    @ApiOperation("人脸识别签到")
    @PostMapping("/{userId}/check-in")
    public Object faceCheckIn(@PathVariable Long userId, @RequestParam("file") MultipartFile file) {
        return userService.faceCheckIn(userId, file);
    }

    @ApiOperation("获取用户签到记录")
    @GetMapping("/{userId}/check-in-records")
    public Object getCheckInRecords(@PathVariable Long userId) {
        return userService.getCheckInRecords(userId);
    }
} 