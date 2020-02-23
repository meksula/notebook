package com.bank.domain.controller;

import com.bank.domain.model.Transaction;
import lombok.AllArgsConstructor;
import org.apache.camel.Produce;
import org.apache.camel.ProducerTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
@RequestMapping("/transaction")
public class TransactionController {

    @Produce(uri = "direct:transaction")
    private ProducerTemplate template;

    @PostMapping
    HttpStatus makeTransaction(@RequestBody Transaction transaction) {
        template.asyncSendBody(template.getDefaultEndpoint(), transaction);
        return HttpStatus.ACCEPTED;
    }
}
