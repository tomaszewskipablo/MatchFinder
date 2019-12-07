﻿using System;
using Xamarin.Forms;
using Xamarin.Forms.Maps;

namespace MatchFinder.GoogleAPI
{
    public class MainMap: ContentPage
    {
        private Locationer locationer = new Locationer();
        private PinManager pinManager = new PinManager();
        private Map mainMap = new Map();

        public MainMap()
        {
            CreateMainMapAsync(); // map with current location
        }

        public async System.Threading.Tasks.Task CreateMainMapAsync()
        {
            await locationer.LoadCurrentPositionAsync();

            double latitude = locationer.getCurrentLatitude();
            double longitude = locationer.getCurrentLongitude();

            // map
            mainMap = new Map(
                MapSpan.FromCenterAndRadius
                (
                    new Position(latitude, longitude),
                    Distance.FromKilometers(50)) // map scale
                );

            // current location pin 
            var pin = new Pin()
            {
                Position = new Position(latitude, longitude),
                Label = "You are here!"
            };
            mainMap.Pins.Add(pin);

            this.Content = mainMap;
            // ADD PINS WITH STADIUMS:
            LoadPinsFromPinManager();
        }

        public void AddPin(double latitude, double longitude, string pinLabel)
        {
            var pin = new Pin()
            {
                Position = new Position(latitude, longitude),
                Label = pinLabel,
                Type = PinType.Place
            };

            this.AddPin(pin);
        }

        public void AddPin(Pin pin)
        {
            mainMap.Pins.Add(pin);
            this.Content = mainMap;
        }

        private void LoadPinsFromPinManager()
        {
            this.pinManager.LoadMainMapPins();

            foreach (var pin in pinManager.pinList)
            {
                mainMap.Pins.Add(pin);
            }
            this.Content = mainMap;
        }
    }
}