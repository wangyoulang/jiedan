package org.com.facecheckin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import lombok.RequiredArgsConstructor;
import org.com.facecheckin.entity.User;
import org.com.facecheckin.entity.CheckInRecord;
import org.com.facecheckin.mapper.UserMapper;
import org.com.facecheckin.mapper.CheckInRecordMapper;
import org.com.facecheckin.service.UserService;
import org.com.facecheckin.util.FaceRecognitionUtil;
import org.com.facecheckin.util.JwtUtil;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;
    private final CheckInRecordMapper checkInRecordMapper;
    private final JwtUtil jwtUtil;
    private final FaceRecognitionUtil faceRecognitionUtil;

    @Override
    public Object register(User user) {
        // 检查用户名是否已存在
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", user.getUsername());
        if (userMapper.selectOne(queryWrapper) != null) {
            throw new RuntimeException("用户名已存在");
        }
        
        // 设置默认角色
        user.setRole("USER");
        userMapper.insert(user);
        return "注册成功";
    }

    @Override
    public Object login(String username, String password) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        User user = userMapper.selectOne(queryWrapper);
        
        if (user == null || !password.equals(user.getPassword())) {
            throw new RuntimeException("用户名或密码错误");
        }
        
        // 生成JWT token
        String token = jwtUtil.generateToken(user);
        
        Map<String, Object> result = new HashMap<>();
        result.put("token", token);
        result.put("user", user);
        return result;
    }

    @Override
    public Object uploadFace(Long userId, MultipartFile file) {
        User user = userMapper.selectById(userId);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }
        
        // 保存人脸图片
        String faceImagePath = faceRecognitionUtil.saveFaceImage(file);
        user.setFaceImage(faceImagePath);
        userMapper.updateById(user);
        
        return "人脸图片上传成功";
    }

    @Override
    public Object faceCheckIn(Long userId, MultipartFile file) {
        User user = userMapper.selectById(userId);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }
        
        // 人脸识别验证
        if (!faceRecognitionUtil.verifyFace(file, user.getFaceImage())) {
            throw new RuntimeException("人脸识别失败");
        }
        
        // 记录签到
        CheckInRecord record = new CheckInRecord();
        record.setUserId(userId);
        record.setCheckInTime(LocalDateTime.now());
        record.setCheckInType("上班打卡"); // 这里可以根据时间判断是上班还是下班
        record.setStatus("正常"); // 这里可以根据时间判断是否迟到早退
        
        checkInRecordMapper.insert(record);
        return "签到成功";
    }

    @Override
    public Object getCheckInRecords(Long userId) {
        QueryWrapper<CheckInRecord> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        queryWrapper.orderByDesc("check_in_time");
        
        List<CheckInRecord> records = checkInRecordMapper.selectList(queryWrapper);
        return records;
    }
} 