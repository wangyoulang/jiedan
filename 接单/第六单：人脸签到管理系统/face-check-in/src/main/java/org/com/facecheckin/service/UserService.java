package org.com.facecheckin.service;

import org.com.facecheckin.entity.User;
import org.springframework.web.multipart.MultipartFile;

public interface UserService {
    Object register(User user);
    
    Object login(String username, String password);
    
    Object uploadFace(Long userId, MultipartFile file);
    
    Object faceCheckIn(Long userId, MultipartFile file);
    
    Object getCheckInRecords(Long userId);
} 