package news.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/security")
public class SecurityController {

    @RequestMapping(value = "/loginfail")
    public String loginFail(Model model){
        model.addAttribute("message","Неверное имя пользователя или пароль");
        return "main";
    }

}
