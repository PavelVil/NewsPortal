package news.controller;

import news.model.Category;
import news.model.Post;
import news.model.User;
import news.service.NewsService;
import news.service.UserService;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;

@Controller
@RequestMapping(value = "/news/admin")
public class AdminController {

    @Autowired
    private NewsService<Post> postService;
    @Autowired
    private NewsService<Category> categoryService;
    @Autowired
    private UserService userService;

    @PreAuthorize("isAuthenticated()")
    @RequestMapping(method = RequestMethod.GET)
    public String adminPage(Model model){
        model.addAttribute("post", new Post());
        model.addAttribute("category", new Category());
        model.addAttribute("categoryList", categoryService.getAll());
        model.addAttribute("userList", userService.getAllUsers());
        model.addAttribute("user", new User());
        model.addAttribute("roles",userService.getAllRoles());
        return "adminPage";
    }

    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/updatePost/{id}",method = RequestMethod.GET)
    public String updatePost(@PathVariable("id") Long id, Model model){
        Post post = postService.getById(id);
        if (post!=null){
            model.addAttribute("post",post);
        }
        model.addAttribute("category", new Category());
        model.addAttribute("categoryList", categoryService.getAll());
        return "adminPage";
    }

    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "addPost",method = RequestMethod.POST, headers = "content-type=multipart/*")
    public String addPost(@RequestParam("categoryOnPost")String categoryName, @ModelAttribute("post") Post post,
                          @RequestParam("file")MultipartFile file){

        if(file!=null){
                setPhoto(file, post);
        }

        if(post.getId()!=null){
            post.setCategory(categoryService.getByName(categoryName));
            postService.update(post);
        } else {
            post.setCategory(categoryService.getByName(categoryName));
            postService.add(post);
        }
        return "redirect:/news/main";
    }

    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/deletePost/{id}")
    public String deletePost(@PathVariable("id") Long id){
        postService.delete(id);
        return "redirect:/news/main";
    }

    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/updateCategory/{id}", method = RequestMethod.GET)
    public String updateCategory(@PathVariable("id") Long id, Model model){
        Category category = categoryService.getById(id);
        if(category!=null){
            model.addAttribute("category",category);
        }
        model.addAttribute("post", new Post());
        model.addAttribute("categoryList", categoryService.getAll());
        return "adminPage";
    }

    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/addCategory", method = RequestMethod.POST)
    public String addCategory(@ModelAttribute("category") Category category){
        if(category.getId()!=null){
            categoryService.update(category);
        } else {
            categoryService.add(category);
        }
        return "redirect:/news/admin";
    }

    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/deleteCategory/{id}")
    public String deleteCategory(@PathVariable("id") Long id){
        categoryService.delete(id);
        return "redirect:/news/admin";
    }

    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/updateUser/{userName}", method = RequestMethod.GET)
    public String updateUser(@PathVariable("userName")String name, Model model){
        model.addAttribute("user", userService.getUserByName(name));
        return "updateUser";
    }

    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/updateUserInfo", method = RequestMethod.POST)
    public String updateUserInfo(@RequestParam("role") String role, @ModelAttribute("user") User user){
        userService.saveRole(user, role);
        userService.updateUser(user);
        return "redirect:/news/admin";
    }

    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/available/{userName}",method = RequestMethod.GET)
    public String updateAvailable(@PathVariable("userName") String userName){
        User user = userService.getUserByName(userName);
        if(user!=null) {
            if (user.isEnabled()) {
                user.setEnabled(false);
            } else {
                user.setEnabled(true);
            }
            userService.updateUser(user);
        }
        return "redirect:/news/admin";
    }

    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/deleteUser/{userName}", method = RequestMethod.GET)
    public String deleteUser(@PathVariable("userName") String userName){
        if(userName!=null && !userName.trim().isEmpty()) {
            userService.deleteUser(userName);
        }
        return "redirect:/news/admin";
    }

    private void setPhoto(MultipartFile file, Post post){
        byte[] fileContent = null;
        try {
            InputStream inputStream = file.getInputStream();
            fileContent = IOUtils.toByteArray(inputStream);
            post.setPhoto(fileContent);
        }catch (IOException ex){
            ex.printStackTrace();
        }
    }

}
