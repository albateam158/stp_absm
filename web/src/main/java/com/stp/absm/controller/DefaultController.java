package com.stp.absm.controller;

import org.springframework.boot.autoconfigure.web.ErrorController;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DefaultController implements ErrorController {


	@RequestMapping(value = "/")
	public String home() {

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

	private static final String PATH = "/error";

	@RequestMapping(value = PATH)
	public String error(Model model) {
		model.addAttribute("message", "");
		return "error";
	}

	@Override
	public String getErrorPath() {
		return PATH;
	}


}
