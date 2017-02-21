package com.stp.absm.controller;

import com.stp.absm.model.XAdmin;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DefaultController {

	@RequestMapping(value = "/")
	public String home(@AuthenticationPrincipal XAdmin userDetail, Model model) {

		return "redirect:/main/form";
	}

	@RequestMapping(value = "/page/{page}")
	public String page(
			@PathVariable(value = "page") String page,
			Model model
	) {

		return "page/" + page;
	}


	@RequestMapping(value = "/modal/{modal}")
	public String modal(
			@PathVariable(value = "modal") String modal,
			Model model
	) {

		return "modal/" + modal;
	}

	@RequestMapping(value = "/error")
	public String error(@RequestParam String message, Model model) {
		model.addAttribute("message", message);
		return "error";
	}
}
