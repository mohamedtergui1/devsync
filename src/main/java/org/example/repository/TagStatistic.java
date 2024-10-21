package org.example.repository;

import org.example.entity.Tag;

import java.util.Map;

public interface TagStatistic extends  StatisticOfEntity{
    Map<Tag,Long> getCountTaskByTag();
}
