package com.bank.domain.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Transaction {
    private UUID transactionUuid;
    private BigDecimal amount;
    private String date = String.valueOf(LocalDateTime.now());
    private String title;
    private Person sender;
    private Person receiver;
}
