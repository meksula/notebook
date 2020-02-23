package com.bank.config;

import com.bank.domain.model.Transaction;
import org.apache.camel.component.jackson.JacksonDataFormat;
import org.apache.camel.builder.RouteBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.UUID;

@Configuration
public class RabbitMQRoute {
    JacksonDataFormat jacksonDataFormat = new JacksonDataFormat(Transaction.class);

    @Bean
    RouteBuilder transactionPublishRoute() {
        return new RouteBuilder() {
            @Override
            public void configure() throws Exception {
//                from("direct:transactionQueue")
//                        .id("transaction-" + new Date())
//                        .marshal(jacksonDataFormat)
//                        .to("rabbitmq://localhost:5672/transaction-exchange?" +
//                                "queue=transaction" +
//                                "&routingKey=transaction-order" +
//                                "&autoDelete=false" +
//                                "&autoAck=true")
//                        .end();
                from("direct:transaction")
                        .id(UUID.randomUUID().toString())
                        .marshal(jacksonDataFormat)
                        .log("Sending transaction on queue.")
                        .to("rabbitmq://localhost:5672/transaction.exchange?queue=transaction.queue&routingKey=trx&autoDelete=false",
                            "rabbitmq://localhost:5672/transaction.exchange?queue=accounting.queue&routingKey=accounting&autoDelete=false")
                        .end();
            }
        };
    }

    @Bean
    RouteBuilder transactionConsumeRoute() {
        return new RouteBuilder() {
            @Override
            public void configure() throws Exception {
                from("rabbitmq://localhost:5672/transaction.exchange?queue=transaction.queue&autoDelete=false")
                        .unmarshal(jacksonDataFormat)
                        .process("accounting")
                        .log("Receiving in Transaction service");
            }
        };
    }

    @Bean
    RouteBuilder transactionAccountantConsumeRoute() {
        return new RouteBuilder() {
            @Override
            public void configure() throws Exception {
                from("rabbitmq://localhost:5672/transaction.exchange?queue=accounting.queue&autoDelete=false")
                        .unmarshal(jacksonDataFormat)
                        .process("accounting")
                        .log("Receiving in Accounting");
            }
        };
    }
}
