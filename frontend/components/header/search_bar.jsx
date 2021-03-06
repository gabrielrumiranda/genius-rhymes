const React = require('react');
const SongActions = window.SongActs = require('../../actions/song_actions');
const SongsIndexItem = require('../song/songs_index_item');
const SongStore = require('../../stores/song_store');
const hashHistory = require('react-router').hashHistory;

const SearchBar = React.createClass({
  getInitialState() {
    return {
      query: "",
      results: SongStore.searchResults(),
      searching: false
    };
  },

  componentDidMount(){
    this.resultsListener = SongStore.addListener(this._onSongsChange);
  },

  componentWillUnmount(){
    this.resultsListener.remove();
  },

  _onSongsChange(){
    this.setState({ results: SongStore.searchResults() });
  },

  handleChange(e){
    e.preventDefault();
    if (e.target.value) {
      SongActions.fetchSongsByQuery(e.target.value);
      this.setState({ searching: true });
    } else {
      this.setState({ searching: false });
      SongActions.fetchSongsByQuery("alphabetical");
    }
    this.setState({ query: e.target.value });
  },

  handleSelect(e){
    e.preventDefault();
    if (e.target.id) {
      this.setState({
        query: e.target.textContent,
      });
    }
    this.setState({
      searching: false,
      query: ""
    });
  },

  render(){
    let results = [];
    let className = "search-bar";
    const onIndex = (location.hash.split(/#|\?/)[1] === "/songs");
    if (this.state.searching && !onIndex) {
      results = this.state.results.map(result => {
        return <SongsIndexItem key={result.id} song={result} />;
      });

      className = "search-bar-selected";
    }

    if (this.state.searching && results.length === 0 && !onIndex) {
      results = <SongsIndexItem nullResult="true" />;
    }

    return(
      <div className={className}>
        <input type="text"
               placeholder="Search songs and artists"
               onFocus={ function(e) { e.target.placeholder = ""; } }
               onBlur={
                 function(e) {
                   e.target.placeholder = "Search for songs and artists";
                 }
               }
               value={this.state.query}
               onChange={this.handleChange}/>
        <div className="search-results" onClick={this.handleSelect}>
          <ul>
            {results}
          </ul>
        </div>
      </div>
    );
  }
});

module.exports = SearchBar;
