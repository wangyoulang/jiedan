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
    
    private LocalDateTime checkInTime;
    
    private String checkInType;  // 上班打卡或下班打卡
    
    private String status;  // 正常、迟到、早退等
    
    private String location;  // 打卡地点
    
    private String remark;
    
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
    
    @TableLogic
    private Integer deleted;
} 