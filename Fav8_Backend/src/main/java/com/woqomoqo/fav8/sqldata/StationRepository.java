package com.woqomoqo.fav8.sqldata;

import org.springframework.data.repository.CrudRepository;

import org.springframework.stereotype.Service;

//import com.woqomoqo.radiostations.api.model.Station;
import com.woqomoqo.fav8.sqldata.model.Station;

// This will be AUTO IMPLEMENTED by Spring into a Bean called stationRepository
// CRUD refers Create, Read, Update, Delete

@Service
public interface StationRepository extends CrudRepository<Station, Integer> {

}