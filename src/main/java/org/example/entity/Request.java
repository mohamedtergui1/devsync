package org.example.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "requests")
public class Request {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    @OneToOne
    @JoinColumn(name = "task_id", nullable = false)
    private Task task;


    @Column(name = "date_of_request", nullable = false)
    private LocalDateTime dateOfRequest;


    @Column(name = "status", nullable = true)
    private char status;


    public Request() {
    }

    public Request(Task task, LocalDateTime dateOfRequest, char status) {
        this.task = task;
        this.dateOfRequest = dateOfRequest;
        this.status = status;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Task getTask() {
        return task;
    }

    public void setTask(Task task) {
        this.task = task;
    }

    public LocalDateTime getDateOfRequest() {
        return dateOfRequest;
    }

    public void setDateOfRequest(LocalDateTime dateOfRequest) {
        this.dateOfRequest = dateOfRequest;
    }

    public char getStatus() {
        return status;
    }

    public void setStatus(char status) {
        this.status = status;
    }

    // toString method for debugging purposes
    @Override
    public String toString() {
        return "Request{" +
                "id=" + id +
                ", task=" + task.getId() +
                ", dateOfRequest=" + dateOfRequest +
                ", status='" + status + '\'' +
                '}';
    }
}
