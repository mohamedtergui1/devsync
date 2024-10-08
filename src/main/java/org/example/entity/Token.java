package org.example.entity;

import jakarta.persistence.*;
import org.example.enums.TokenType;

import java.util.Date;

@Entity
@Table(name = "tokens")
public class Token {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Enumerated(EnumType.STRING)
    private TokenType type;

    private Date expirationDate;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    // Constructor, Getters, Setters
    public Token() {
    }

    public Token(TokenType type, Date expirationDate, User user) {
        this.type = type;
        this.expirationDate = expirationDate;
        this.user = user;
    }

    // Getters and setters...

    public Date getExpirationDate() {
        return expirationDate;
    }

    public int getId() {
        return id;
    }

    public TokenType getType() {
        return type;
    }

    public User getUser() {
        return user;
    }

    public void setExpirationDate(Date expirationDate) {
        this.expirationDate = expirationDate;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setType(TokenType type) {
        this.type = type;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
