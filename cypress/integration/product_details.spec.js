/// <reference types="cypress" />

describe('home page' , () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000')
  })

  it('visits our home page', () => {
    cy.visit('http://localhost:3000')
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });
  it("There is 12 products on the page", () => {
    cy.get(".products article").should("have.length", 12);
  });
//since we have more than 1 product, .eq(0) will get the first index of products article
  it('clicks on a product to navigate to product detail', () => {
    cy.get('.products article').eq(0).click()
  });
})