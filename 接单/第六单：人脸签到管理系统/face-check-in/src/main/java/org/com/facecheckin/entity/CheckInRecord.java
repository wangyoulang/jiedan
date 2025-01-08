package org.com.facecheckin.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("check_in_record")
public class CheckInRecord {
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private Long userId;
    
    private String userName;  // 用户姓名
    
    private LocalDateTime checkInTime;
    
    private String checkInType;  // 签到类型（上班打卡/下班打卡）
    
    private String status;  // 状态（正常/迟到/早退）
    
    private String location;  // 签到地点
    
    private String remark;  // 备注
    
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
    
    @TableLogic
    private Boolean deleted;
} 