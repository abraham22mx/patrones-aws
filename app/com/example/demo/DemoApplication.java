package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;

import software.amazon.awssdk.services.ssm.*;
import software.amazon.awssdk.services.ssm.model.*;

@SpringBootApplication
@RestController
public class DemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

    @GetMapping("/")
    public String getMessage() {

        SsmClient ssm = SsmClient.create();

        GetParameterRequest request = GetParameterRequest.builder()
                .name("/demo/app/message")
                .build();

        GetParameterResponse response = ssm.getParameter(request);

        return response.parameter().value();
    }
}
