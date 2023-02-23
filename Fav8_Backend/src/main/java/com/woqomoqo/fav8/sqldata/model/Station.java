package com.woqomoqo.fav8.sqldata.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import org.hibernate.annotations.GenericGenerator;

import javax.annotation.Generated;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Objects;

/**
 * This is the radio station model
 */

@Schema(name = "Station", description = "This is the radio station model")
@Generated(value = "org.openapitools.codegen.languages.SpringCodegen", date = "2022-12-04T20:04:26.122778+01:00[Europe/Stockholm]")

@Entity // This tells Hibernate to make a table out of this class
public class Station implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id @GeneratedValue(generator="system-uuid")
    @GenericGenerator(name="system-uuid", strategy = "uuid")
    @JsonProperty("id")
    private String id = null;

    @JsonProperty("stationName")
    private String stationName;

    @JsonProperty("stationUrl")
    private String stationUrl;

    public Station id(String id) {
        this.id = id;
        return this;
    }

    /**
     * The id of the radio station
     * @return id
     */
    @NotNull
    @Schema(name = "id", description = "The id of the radio station", required = true)
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Station stationName(String stationName) {
        this.stationName = stationName;
        return this;
    }

    /**
     * The name of the radio station
     * @return stationName
     */
    @NotNull
    @Schema(name = "stationName", description = "The name of the radio station", required = true)
    public String getStationName() {
        return stationName;
    }

    public void setStationName(String stationName) {
        this.stationName = stationName;
    }

    public Station stationUrl(String stationUrl) {
        this.stationUrl = stationUrl;
        return this;
    }

    /**
     * The streaming url of the radio station
     * @return stationUrl
     */
    @NotNull
    @Schema(name = "stationUrl", description = "The streaming url of the radio station", required = true)
    public String getStationUrl() {
        return stationUrl;
    }

    public void setStationUrl(String stationUrl) {
        this.stationUrl = stationUrl;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        com.woqomoqo.radiostations.api.model.Station station = (com.woqomoqo.radiostations.api.model.Station) o;
        return Objects.equals(this.id, station.getId()) &&
                Objects.equals(this.stationName, station.getStationName()) &&
                Objects.equals(this.stationUrl, station.getStationUrl());
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, stationName, stationUrl);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("class Station {\n");
        sb.append("    id: ").append(toIndentedString(id)).append("\n");
        sb.append("    stationName: ").append(toIndentedString(stationName)).append("\n");
        sb.append("    stationUrl: ").append(toIndentedString(stationUrl)).append("\n");
        sb.append("}");
        return sb.toString();
    }

    /**
     * Convert the given object to string with each line indented by 4 spaces
     * (except the first line).
     */
    private String toIndentedString(Object o) {
        if (o == null) {
            return "null";
        }
        return o.toString().replace("\n", "\n    ");
    }
}

