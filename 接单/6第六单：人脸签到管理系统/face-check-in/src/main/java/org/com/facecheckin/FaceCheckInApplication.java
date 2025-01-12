package org.com.facecheckin;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import springfox.documentation.oas.annotations.EnableOpenApi;

@EnableOpenApi
@SpringBootApplication
public class FaceCheckInApplication {

    public static void main(String[] args) {
        SpringApplication.run(FaceCheckInApplication.class, args);
    }

}
