function [Posbasket_upcorner,Posbasket_downcorner]=posbasket(xpos_basket,ypos_basket,size_basket,shape_ratio_basket)

size_basket_x=size_basket;
size_basket_y=size_basket/shape_ratio_basket;

Posbasket_upcorner=round([xpos_basket,ypos_basket]-2^0.5/2*[size_basket_x,size_basket_y]);
Posbasket_downcorner=round([xpos_basket,ypos_basket]+2^0.5/2*[size_basket_x,size_basket_y]);
