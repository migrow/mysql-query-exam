use travel;

/*
1) Select a distinct list of ordered airports codes.
*/
SELECT departAirport FROM flight GROUP BY departAirport;

/*
2) Provide a list of delayed flights departing from San Francisco (SFO).
*/
SELECT airline.name, flight.flightNumber, flight.scheduledDepartDateTime, flight.arriveAirport, flight.status from flight inner join airline on flight.airlineID = airline.ID where flight.status ='delayed' and flight.departAirport = 'SFO';

/*
3) Provide a distinct list of cities that American airlines departs from.
*/
SELECT flight.departAirport as Cities from flight inner join airline on airline.ID = flight.airlineID where airline.name = 'American' group by flight.departAirport;

/*
4) Provide a distinct list of airlines that conducts flights departing from ATL.
*/

SELECT airline.name AS Airline FROM flight INNER JOIN airline ON airline.ID = flight.airlineID where departAirport = 'ATL' GROUP BY airline.name;

/*
5) Provide a list of airlines, flight numbers, departing airports, and arrival airports where flights departed on time.
*/
select airline.name, flight.flightNumber, flight.departAirport, flight.arriveAirport from flight inner join airline on airline.ID = flight.airlineID where flight.scheduledDepartDateTime = flight.actualDepartDateTime;

/*
6) Provide a list of airlines, flight numbers, gates, status, and arrival times arriving into Charlotte (CLT) on 10-30-2017. Order your results by the arrival time.
*/
select airline.name as Airline, flight.flightNumber as Flight, flight.gate as Gate, TIME(flight.scheduledArriveDateTime) as Arrival, flight.status as Status from flight inner join airline on airline.ID = flight.airlineID where flight.arriveAirport = 'CLT' AND DATE(flight.scheduledArriveDateTime) = '2017-10-30';

/*
7) List the number of reservations by flight number. Order by reservations in descending order.
*/
select flight.flightNumber as flight, count(reservation.flightID) as reservations from reservation inner join flight on flight.ID = reservation.flightID group by reservation.flightID order by count(reservation.flightID) desc;

/*
8) 
*/
select airline.name as airline, flight.departAirport, flight.arriveAirport, AVG(reservation.cost) as AverageCost from flight inner join airline on airline.id = flight.airlineID inner join reservation on reservation.flightID = flight.ID where reservation.class = 'coach' group by airline.name, flight.departAirport, flight.arriveAirport order by AverageCost desc;


/*
9) Which route is the longest?
*/
select departAirport, arriveAirport, max(miles) as miles from flight group by departAirport, arriveAirport order by max(miles) desc limit 1;

/*
10) List the top 5 passengers that have flown the most miles. Order by miles.
*/
select passenger.firstName, passenger.lastName, sum(flight.miles) as miles from reservation inner join flight on flight.ID = reservation.flightID inner join passenger on passenger.ID = reservation.passengerID group by passenger.firstName, passenger.lastName order by miles desc, passenger.lastName desc limit 5;

/*
11) Provide a list of American airline flights ordered by route and arrival date and time.
*/
SELECT airline.name as Name, CONCAT(flight.departAirport, ' --> ', flight.arriveAirport) as Route, DATE(flight.scheduledArriveDateTime) as 'Arrive Date', TIME(flight.scheduledArriveDateTime) as 'Arrive Time' from flight inner join airline on airline.ID = flight.airlineID where airline.name = 'American' ORDER BY Route, DATE(flight.scheduledArriveDateTime) asc, TIME(flight.scheduledArriveDateTime) asc;

/*
12) Provide a report that counts the number of reservations and totals the reservation costs (as Revenue) by Airline, flight, and route. Order the report by total revenue in descending order.
*/
SELECT airline.name as Airline, flight.flightNumber as Flight, CONCAT(flight.departAirport, ' --> ', flight.arriveAirport) as Route, COUNT(reservation.flightID) as 'Reservation Count', SUM(reservation.cost) as Revenue from flight inner join airline on airline.ID = flight.airlineID inner join reservation on reservation.flightID = flight.ID GROUP BY airline.name, flight.flightNumber, Route ORDER BY Revenue desc;

/*
13) List the average cost per reservation by route. Round results down to the dollar.
*/
select CONCAT(flight.departAirport, ' --> ', flight.arriveAirport) as Route, FLOOR(AVG(reservation.cost)) as 'Avg Revenue' from reservation inner join flight on flight.ID = reservation.flightID group by Route ORDER BY AVG(reservation.cost) desc;

/*
14) List the average miles per flight by airline.
*/
SELECT airline.name as Airline, AVG(flight.miles) as 'Avg Miles Per Flight' from flight inner join airline on airline.id = flight.airlineID GROUP BY Airline;

/*
15) Which airlines had flights that arrived early?
*/
 select airline.name as Airline from flight inner join airline on airline.id = flight.airlineID where flight.scheduledArriveDateTime > flight.actualArriveDateTime GROUP BY airline.name;