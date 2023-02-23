//package com.woqomoqo.fav8.mockdata;
//
//import com.woqomoqo.radiostations.api.RadioStationsApi;
//import com.woqomoqo.radiostations.api.model.RadioStationsList;
//import io.swagger.annotations.ApiOperation;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.CrossOrigin;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import java.util.List;
//
//@Controller // This means that this class is a Controller
//@RequestMapping(path = "/api") // This means URL's start with /demo (after Application path)
//public class RadioStationsController implements RadioStationsApi {
//
//    private final RadioStationsRepository radioStationsRepository;
//
//    public RadioStationsController(RadioStationsRepository radioStationsRepository) {
//        this.radioStationsRepository = radioStationsRepository;
//    }
//
//    // @Override
//    @GetMapping("/stations")
//    @CrossOrigin(origins = "http://localhost:4200")
//    @ApiOperation("Returns list of radio stations")
//    public ResponseEntity<List<RadioStationsList>> getStations() {
//        return new ResponseEntity<>(this.radioStationsRepository.getAllRadioStations(),
//                HttpStatus.OK);
//    }
//}