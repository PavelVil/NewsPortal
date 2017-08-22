package news.controller;

import news.model.*;
import news.service.NewsService;
import news.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping(value = "/news")
public class NewsPortalController {

    @Autowired
    private NewsService<Post> postService;
    @Autowired
    private NewsService<Category> categoryService;
    @Autowired
    private UserService userService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String main(){return "redirect:/news/main";}

    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String mainPage(@RequestParam(required = false)Integer page, Model model){
        model.addAttribute("categoryList",categoryService.getAll());
        PagedListHolder<Post> pagedListHolder = new PagedListHolder<>(postService.getAll());
        pagination(page,4,model,pagedListHolder,"postList");

        return "main";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model){
        model.addAttribute("user", new User());
        return "registration";
    }

    @RequestMapping(value = "/addUser", method = RequestMethod.POST)
    public String addUser(@RequestParam("role")String role, @ModelAttribute("user") User user){
            userService.addUser(user);
            userService.saveRole(user, role);
        return "redirect:/news/main";
    }

    @RequestMapping(value = "/category/{id}",method = RequestMethod.GET)
    public String getPostsFromCategory(@PathVariable("id") Long id, @RequestParam(required = false)Integer page, Model model){
        Category category = categoryService.getById(id);
        if(category!=null) {
            PagedListHolder<Post> pagedListHolder = new PagedListHolder<>(postService.getAllWithDetail(category));
            pagination(page,3,model,pagedListHolder,"postsInCategory");
            model.addAttribute("categoryId", id);
        }
        model.addAttribute("categoryList",categoryService.getAll());
        return "postsFromCategory";
    }

    @RequestMapping(value = "/post/{id}", method = RequestMethod.GET)
    public String getPost(@PathVariable("id") Long id, Model model){
        Post post = postService.getById(id);
        if(post!=null){
            model.addAttribute("post",post);
            model.addAttribute("commentList", userService.getCommentsByCategoryId(post));
        }
        model.addAttribute("categoryList",categoryService.getAll());
        model.addAttribute("comment", new Comment());
        return "post";
    }

    @RequestMapping(value = "/photo/{id}",method = RequestMethod.GET)
    @ResponseBody
    public byte[] downloadPhoto(@PathVariable("id")Long id){
        Post post = postService.getById(id);
        return post.getPhoto();
    }

    @RequestMapping(value = "/post/addComment", method = RequestMethod.POST, consumes = "application/json")
    public @ResponseBody String addComment(@RequestBody CommentDTO comment){

    Comment com = new Comment(comment.getComment());
    User user = userService.getUserByName(comment.getUsername());
    Post post = postService.getById(comment.getPostId());

    if(user!=null && post!=null) {
        userService.addComment(com, user, post);
        return "Ok";
    }

    return "Failed";
}

    @RequestMapping(value = "/post/{postId}/deleteComment/{id}", method = RequestMethod.GET)
    public String deleteComment(@PathVariable("postId")Long postId,@PathVariable("id")Long commentId){
        userService.deleteComment(commentId);
        return "redirect:/news/post/"+Long.toString(postId);
    }

    private void pagination(Integer page, Integer pageSize, Model model, PagedListHolder<?> pagedListHolder, String attributeName){
        pagedListHolder.setPageSize(pageSize);
        model.addAttribute("maxPages", pagedListHolder.getPageCount());

        if (page == null || page < 1 || page > pagedListHolder.getPageCount())
            page = 1;
        model.addAttribute("page", page);

        if (page == null || page < 1 || page > pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(0);
            model.addAttribute(attributeName, pagedListHolder.getPageList());
        } else if (page <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(page - 1);
            model.addAttribute(attributeName, pagedListHolder.getPageList());
        }
    }
}
