<%@ page language="java"%>

<%!
    public class PizzaDetails{
        private String pizzaNo;
        private String pizzaName;
        private int smallPizzaQuantity;
        private int mediumPizzaQuantity;
        private int largePizzaQuantity;
        
        public String getPizzaNo() {
            return pizzaNo;
        }

        public void setPizzaNo(String pizzaNo) {
            this.pizzaNo = pizzaNo;
        }

        public String getPizzaName() {
            return pizzaName;
        }

        public void setPizzaName(String pizzaName) {
            this.pizzaName = pizzaName;
        }

        public int getSmallPizzaQuantity() {
            return smallPizzaQuantity;
        }

        public void setSmallPizzaQuantity(int smallPizzaQuantity) {
            this.smallPizzaQuantity = smallPizzaQuantity;
        }

        public int getMediumPizzaQuantity() {
            return mediumPizzaQuantity;
        }

        public void setMediumPizzaQuantity(int mediumPizzaQuantity) {
            this.mediumPizzaQuantity = mediumPizzaQuantity;
        }

        public int getLargePizzaQuantity() {
            return largePizzaQuantity;
        }

        public void setLargePizzaQuantity(int largePizzaQuantity) {
            this.largePizzaQuantity = largePizzaQuantity;
        }
    }
%>