package org.example.service;

import org.example.entity.Tag;

import java.util.Map;

public interface StatisticService {
    Map<String,Long> getStatisticscOUNT();
    Map<Tag,Long> getCountTasksByTag();
}
