/**
 * Created by Rodrigo Collavo on 1/27/15.
 */
package com.rc.framework {
import com.rc.framework.playarea.PlayArea;
import com.rc.framework.cards.AbstractCard;
import com.rc.framework.cards.AbstractCard;
import com.rc.framework.deck.AbstractDeck;
import com.rc.framework.playarea.PlayAreaFactory;
import com.rc.framework.rules.GameRules;
import com.rc.framework.statemachine.StateManager;

import flash.utils.Dictionary;

import starling.display.Sprite;
import starling.errors.AbstractMethodError;
import starling.utils.formatString;

public class AbstractBoard extends Sprite {
    private var _decks:Dictionary;
    private var _playArea:Dictionary;
    protected var _player:Player;
    protected var _playerCards:Vector.<AbstractCard>;
    protected var _turnTimer:TurnController;
    protected var _stateManager:StateManager;
    protected var _gameRules:GameRules;
    protected var _difficulty:uint = 0;

    public function AbstractBoard() {
        prepare();
    }

    private function prepare():void {
        _decks = new Dictionary();
        _playArea = new Dictionary();
        _player = new Player();
        _playerCards = new Vector.<AbstractCard>();
        _turnTimer = new TurnController(getTotalGameTurns());
        _gameRules = new GameRules();

        createRules();
        defineTurnEvents();
    }

    public function start():void {
        throw new AbstractMethodError();
    }

    public function changeState(state:String):void {
        if(!_stateManager)
            throw new Error("StateManager not prepared");
        _stateManager.changeState(state);
    }

    public function advanceTurn():void {
        _turnTimer.advanceTurn();
    }

    public function getCurrentTurn():int {
        return _turnTimer.currentTurn;
    }

    protected function getTotalGameTurns():int {
        throw new AbstractMethodError();
    }

    protected function getMaxPlayerCards():int {
        throw new AbstractMethodError();
    }

    protected function loadDeck():void {
        throw new AbstractMethodError();
    }

    protected function createRules():void {
        throw new AbstractMethodError();
    }

    protected function defineTurnEvents():void {
        throw new AbstractMethodError();
    }

    public function addDeck(deck:AbstractDeck, deckName:String):void {
        if(_decks[deckName] != null)
          throw new Error("deck '" + deckName + "' already exists");
        _decks[deckName] = deck;
    }

    public function getDeck(deckName:String):AbstractDeck {
        return _decks[deckName];
    }

    public function addPlayerCard(card:AbstractCard):void {
        if(_playerCards.length < getMaxPlayerCards())
            _playerCards.push(card);
        else
            trace(formatString("Can't add player item %s (type %d). Max has been reached", card.getName(), card.getType()));
    }

    public function get playerCards():Vector.<AbstractCard> {
        return _playerCards;
    }

    public function get player():Player {
        return _player;
    }

    /*
        Create space in your table with a specific tag name, you will have a pool of cards
        played by your game.
        e.g. 'heroes_applying_quest', 'enemies_staging_area', 'enemies_engaged_with_player'
     */
    public function createPlayArea(type:String, name:String, deck:AbstractDeck, extraData:Object = null):void {
        if(_playArea[name] != null) {
            throw new Error("Play area already exists with name " + name);
        }
        _playArea[name] = PlayAreaFactory.build(type, name, deck, extraData);
    }

    public function getCardInPlayArea(name:String, index:int):AbstractCard {
        var playArea:PlayArea = _playArea[name];
        return playArea.getCardAt(index);
    }

    public function freePlayArea(name:String):void {
        delete _playArea[name];
    }

    public function removeCardFromPlayArea(card:AbstractCard, name:String):void {
        var playArea:PlayArea = _playArea[name];
        playArea.removeCard(card);
    }

    public function getPlayAreaForCard(card:AbstractCard):String {
        for (var areaName:String in _playArea) {
            var playArea:PlayArea = _playArea[areaName];
            var cards:Vector.<AbstractCard> = playArea.getCards();
            if(cards.indexOf(card) >= 0) {
                return areaName;
            }
        }
        return null;
    }
}
}

