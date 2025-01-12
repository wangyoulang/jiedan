package org.com.facecheckin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.com.facecheckin.entity.CheckInRecord;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CheckInRecordMapper extends BaseMapper<CheckInRecord> {
} 