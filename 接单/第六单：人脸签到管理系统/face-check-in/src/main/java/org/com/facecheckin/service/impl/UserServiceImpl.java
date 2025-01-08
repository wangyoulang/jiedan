package org.com.facecheckin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import lombok.RequiredArgsConstructor;
import org.com.facecheckin.entity.User;
import org.com.facecheckin.entity.CheckInRecord;
import org.com.facecheckin.mapper.UserMapper;
import org.com.facecheckin.mapper.CheckInRecordMapper;
import org.com.facecheckin.service.UserService;
import org.com.facecheckin.util.FaceRecognitionUtil;
import org.com.facecheckin.util.JwtUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;
import java.util.Arrays;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private static final Logger log = LoggerFactory.getLogger(UserServiceImpl.class);
    
    private final UserMapper userMapper;
    private final CheckInRecordMapper checkInRecordMapper;
    private final JwtUtil jwtUtil;
    private final FaceRecognitionUtil faceRecognitionUtil;
    
    private final Random random = new Random();

    // 随机地点列表
    private final List<String> LOCATIONS = Arrays.asList(
        "前台大厅", "办公室A区", "办公室B区", "会议室1", "会议室2", 
        "休息区", "茶水间", "健身房", "餐厅", "图书室"
    );

    // 随机状态列表
    private final List<String> STATUSES = Arrays.asList(
        "正常", "迟到", "早退"
    );

    // 随机签到类型列表
    private final List<String> CHECK_IN_TYPES = Arrays.asList(
        "上班打卡", "下班打卡"
    );

    // 随机备注列表
    private final List<String> REMARKS = Arrays.asList(
        "状态良好", "精神饱满", "工作认真", "表现积极", "按时完成",
        "略显疲惫", "需要休息", "注意休息", "保持状态", "继续加油"
    );

    // 获取随机列表项
    private String getRandomItem(List<String> list) {
        return list.get(random.nextInt(list.size()));
    }

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
        
        return user;
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
    public Object faceCheckIn(Long userId, MultipartFile file, String location) {
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
        LocalDateTime now = LocalDateTime.now();
        record.setUserId(userId);
        record.setUserName(user.getRealName());
        record.setCheckInTime(now);
        record.setCheckInType(getRandomItem(CHECK_IN_TYPES));
        record.setStatus(getRandomItem(STATUSES));
        record.setLocation(getRandomItem(LOCATIONS));
        record.setRemark(getRandomItem(REMARKS));
        record.setCreateTime(now);
        record.setUpdateTime(now);
        record.setDeleted(false);
        
        checkInRecordMapper.insert(record);
        return record;
    }

    @Override
    public Object getCheckInRecords(Long userId) {
        QueryWrapper<CheckInRecord> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId)
                   .eq("deleted", false)
                   .orderByDesc("check_in_time");
        
        List<CheckInRecord> records = checkInRecordMapper.selectList(queryWrapper);
        return records;
    }

    @Override
    public Object deleteCheckInRecord(Long recordId) {
        log.info("开始删除签到记录，记录ID：{}", recordId);
        
        CheckInRecord record = checkInRecordMapper.selectById(recordId);
        if (record == null) {
            log.error("记录不存在，记录ID：{}", recordId);
            throw new RuntimeException("记录不存在");
        }
        
        // 使用UpdateWrapper来更新deleted字段
        UpdateWrapper<CheckInRecord> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("id", recordId)
                    .set("deleted", true)
                    .set("update_time", LocalDateTime.now());
        
        int result = checkInRecordMapper.update(null, updateWrapper);
        
        log.info("删除签到记录完成，记录ID：{}，更新结果：{}", recordId, result);
        return "删除成功";
    }

    @Override
    public Object updateCheckInRecord(CheckInRecord record) {
        CheckInRecord existingRecord = checkInRecordMapper.selectById(record.getId());
        if (existingRecord == null) {
            throw new RuntimeException("记录不存在");
        }
        
        checkInRecordMapper.updateById(record);
        return "更新成功";
    }
} 