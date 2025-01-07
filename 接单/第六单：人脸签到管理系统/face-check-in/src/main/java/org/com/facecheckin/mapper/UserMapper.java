package org.com.facecheckin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.com.facecheckin.entity.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper extends BaseMapper<User> {
} 