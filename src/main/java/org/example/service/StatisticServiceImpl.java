package org.example.service;

import org.example.entity.Tag;
import org.example.repository.*;

import java.util.HashMap;
import java.util.Map;

public class StatisticServiceImpl implements StatisticService {
    StatisticOfEntity usersCount;
    TagStatistic tagsCount;
    StatisticOfEntity tasksCount;

    public StatisticServiceImpl() {
        usersCount = new UserRepositoryImpl();
        tagsCount = new TagRepositoryImpl();
        tasksCount = new TaskRepositoryImpl();
    }

    @Override
    public Map<String, Long> getStatisticscOUNT() {
        Map<String, Long> map = new HashMap<>();
        map.put("usersCount", usersCount.getCount());
        map.put("tagsCount", tagsCount.getCount());
        map.put("tasksCount", tasksCount.getCount());
        return map;
    }

    @Override
    public Map<Tag, Long> getCountTasksByTag() {
        return tagsCount.getCountTaskByTag();
    }
}
