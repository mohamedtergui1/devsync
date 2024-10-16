package org.example.entity;

import jakarta.persistence.*;
import org.example.enums.TokenType;

import java.util.Date;

@Entity
@Table(name = "tokens")
public class Token {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @OneToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id", unique = true)
    private User user;

    // New fields for deletion and update token counts
    @Column(name = "deletion_token_count", nullable = false)
    private int deletionTokenCount = 1;  // Initialized to 1

    @Column(name = "update_token_count", nullable = false)
    private int updateTokenCount = 2;  // Initialized to 2

    // Constructor, Getters, Setters
    public Token() {
    }

    public Token(TokenType type, User user) {


        this.user = user;
    }

    // Getters and setters...



    public long getId() {
        return id;
    }


    public User getUser() {
        return user;
    }

    public int getDeletionTokenCount() {
        return deletionTokenCount;
    }

    public int getUpdateTokenCount() {
        return updateTokenCount;
    }


    public void setId(long id) {
        this.id = id;
    }



    public void setUser(User user) {
        this.user = user;
    }

    public void setDeletionTokenCount(int deletionTokenCount) {
        this.deletionTokenCount = deletionTokenCount;
    }

    public void setUpdateTokenCount(int updateTokenCount) {
        this.updateTokenCount = updateTokenCount;
    }
}