package in.in60minutes.Jenkins_demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeController {

    @GetMapping("/")
    public String home(){
        return "Hello Spring Boot ...";
    }

    @GetMapping("/raj")
    public String raj(){
        return "Hello Raj ...";
    }
}
