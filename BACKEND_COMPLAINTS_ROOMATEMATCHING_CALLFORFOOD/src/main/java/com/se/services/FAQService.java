package com.se.services;

import com.se.models.FAQ;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class FAQService {

        private List<FAQ> faqList = new ArrayList<>();

        public FAQService() {
                faqList.add(new FAQ("What is the check-in time?", "The check-in time is 6:00 AM."));
                faqList.add(new FAQ("What is the check-out time?", "The check-out time is 8:30 PM."));
                faqList.add(new FAQ("What are the hostel rules regarding guests?",
                                "Guests are allowed only between 6:00 AM and 8:00 PM with prior permission."));
                faqList.add(new FAQ("How can I make a room booking?",
                                "You can make a booking through the hostel management portal."));
                faqList.add(new FAQ("Are pets allowed in the hostel?", "No, pets are not allowed in the hostel."));
                faqList.add(new FAQ("What are the hostel's food facilities?",
                                "The hostel provides three meals a day in the common dining area."));
                faqList.add(new FAQ("Is there Wi-Fi available in the hostel?",
                                "Yes, Wi-Fi is available in all rooms and common areas."));
                faqList.add(new FAQ("Can I request for a late check-out?",
                                "Late check-out is subject to availability and must be approved by the hostel management."));
                faqList.add(new FAQ("Is there a laundry service available?",
                                "Yes, the hostel offers laundry services."));
                faqList.add(new FAQ("What should I do in case of a medical emergency?",
                                "Please contact the hostel warden immediately for assistance."));
                faqList.add(new FAQ("Can I extend my stay at the hostel?",
                                "Extensions are possible, but you must check with the hostel administration for availability."));
                faqList.add(new FAQ("How do I report a complaint or issue?",
                                "You can submit a complaint through the hostel's online complaint system or directly to the hostel administration."));
                faqList.add(new FAQ("Is there a curfew for hostel residents?",
                                "Yes, the curfew is at 11:30 PM for all residents."));
                faqList.add(new FAQ("Are visitors allowed in the hostel?",
                                "Visitors are allowed only in the common areas between 6:00 AM and 11:00 PM, with prior approval from the administration."));
                faqList.add(new FAQ("How can I get my room cleaned?",
                                "Room cleaning services are provided upon request. You can contact the warden for assistance."));
        }

        public List<FAQ> getAllFAQs() {
                return faqList;
        }

        public String getAnswerForQuestion(String question) {
                for (FAQ faq : faqList) {
                        if (faq.getQuestion().toLowerCase().contains(question.toLowerCase())) {
                                return faq.getAnswer();
                        }
                }
                return "Sorry, I don't have an answer to that question.";
        }
}
