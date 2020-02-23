package com.bank.domain.consumers;

import com.bank.domain.model.Transaction;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.camel.Exchange;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AccountingConsumer {

    @Bean(name = "accounting")
    Consume accountingConsumer() {
        ObjectMapper objectMapper = new ObjectMapper();

        return new Consume() {
            @Override
            public void consume(Transaction transaction) {
                System.out.println("Received transaction for money: " + transaction.getAmount().toString());
            }

            @Override
            public void process(Exchange exchange) throws Exception {
                System.out.println(">>> Received: " + objectMapper.writeValueAsString(exchange.getMessage().getBody()));
            }
        };
    }
}
