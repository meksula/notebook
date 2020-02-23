package com.bank.domain.consumers;

import com.bank.domain.model.Transaction;
import org.apache.camel.Processor;

public interface Consume extends Processor {
    void consume(Transaction transaction);
}
