package org.com.facecheckin.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.com.facecheckin.entity.User;
import org.com.facecheckin.entity.CheckInRecord;
import org.com.facecheckin.service.UserService;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.util.Map;

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
    public Object login(@RequestBody Map<String, String> loginForm) {
        return userService.login(loginForm.get("username"), loginForm.get("password"));
    }

    @ApiOperation("上传人脸图片")
    @PostMapping("/{userId}/face")
    public Object uploadFace(@PathVariable Long userId, @RequestParam("file") MultipartFile file) {
        return userService.uploadFace(userId, file);
    }

    @ApiOperation("人脸识别签到")
    @PostMapping("/{userId}/check-in")
    public Object faceCheckIn(@PathVariable Long userId, @RequestParam("file") MultipartFile file, 
                            @RequestParam(required = false) String location) {
        return userService.faceCheckIn(userId, file, location);
    }

    @ApiOperation("获取用户签到记录")
    @GetMapping("/{userId}/check-in-records")
    public Object getCheckInRecords(@PathVariable Long userId) {
        return userService.getCheckInRecords(userId);
    }

    @ApiOperation("删除签到记录")
    @DeleteMapping("/check-in-records/{recordId}")
    public Object deleteCheckInRecord(@PathVariable Long recordId) {
        return userService.deleteCheckInRecord(recordId);
    }

    @ApiOperation("更新签到记录")
    @PutMapping("/check-in-records/{recordId}")
    public Object updateCheckInRecord(@PathVariable Long recordId, @RequestBody CheckInRecord record) {
        record.setId(recordId);
        return userService.updateCheckInRecord(record);
    }
} 