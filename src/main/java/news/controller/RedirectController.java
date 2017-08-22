package news.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by Pavel on 22.08.2017.
 */
@Controller
public class RedirectController {

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String redirectOnMain(){
        return "redirect:/news/main";
    }

}
